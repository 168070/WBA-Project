using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI;
using MarasMVC.Models;
using System.Security.Cryptography;
using System.Text;
using System.Diagnostics;
using System.Text.RegularExpressions;



namespace MarasMVC.Controllers
{

    [HandleError]
    public class AccountController : Controller
    {

        private sklepEntities db = new sklepEntities();

        // This constructor is used by the MVC framework to instantiate the controller using
        // the default forms authentication and membership providers.

        public AccountController()
            : this(null, null)
        {
        }

        // This constructor is not used by the MVC framework but is instead provided for ease
        // of unit testing this type. See the comments at the end of this file for more
        // information.
        public AccountController(IFormsAuthentication formsAuth, IMembershipService service)
        {
            FormsAuth = formsAuth ?? new FormsAuthenticationService();
            MembershipService = service ?? new AccountMembershipService();
        }

        public IFormsAuthentication FormsAuth
        {
            get;
            private set;
        }

        public IMembershipService MembershipService
        {
            get;
            private set;
        }

        public ActionResult LogOn()
        {

            /*
            //Response.Cookies.Clear();
            HttpCookie objCookie = new HttpCookie(User.Identity.Name + "myCookieCart");
            Response.Cookies.Clear();
            Response.Cookies.Add(objCookie);
            objCookie.Values.Add(User.Identity.Name + "myCookieCart",".");
            DateTime dtExpiry = DateTime.Now.AddDays(1);
            Response.Cookies[User.Identity.Name + "myCookieCart"].Expires = dtExpiry;
            Response.Cookies.Set(objCookie);
            */
          //  var cook = HttpContext.Request.Cookies.Get(User.Identity.Name + "myCookieCart");


            //HttpContext.Request.Cookies.Remove(User.Identity.Name + "myCookieCart");
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1054:UriParametersShouldNotBeStrings",
            Justification = "Needs to take same parameter type as Controller.Redirect()")]
        public ActionResult LogOn(string userName, string password, bool rememberMe, string returnUrl)
        {

            if (!ValidateLogOn(userName, password))
            {
                return View();
            }

            FormsAuth.SignIn(userName, rememberMe);


            var cook = HttpContext.Request.Cookies.Get(User.Identity.Name + "myCookieCart");

            //czyszczenie ciastka
            var newCookie = new HttpCookie(userName + "myCookieCart", ".");
            newCookie.Expires = DateTime.Now.AddDays(1);
            Response.AppendCookie(newCookie);

            if (!String.IsNullOrEmpty(returnUrl))
            {
                return Redirect(returnUrl);   
            }
            else
            {
                /*
                string con = "Index";
                if (User.IsInRole("Sprzedawca")) con = "Sales";
                else if (User.IsInRole("Administrator")) con = "Admin";
                return RedirectToAction(con+"/Index");
                */

                string controler = "Home"; //dla zwykłych klientów

                if (Roles.IsUserInRole(userName, "Administrator")) controler = "Admin";
                else if (Roles.IsUserInRole(userName, "Sprzedawca")) controler = "sales";
                return RedirectToAction("Index", controler);
               
            }
        }

        public ActionResult LogOff()
        {

            FormsAuth.SignOut();

            return RedirectToAction("Index", "Home");
        }

        public ActionResult Register()
        {

            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            return View();
        }

        [Authorize(Roles = "Administrator")]
        public ActionResult RegisterSp()
        {

            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            return View();
        }

        [Authorize(Roles = "Administrator")]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult RegisterSp(string imie, string nazwisko, string stanowisko, string nip, string userName, string password, string confirmPassword, string email)
        {
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            if (ValidateRegistration(userName, email, password, confirmPassword, imie, nazwisko, nip, "Randomcity", "00-000", "Randomstreet", "0", "000000"))
            {
                // Attempt to register the user
                MembershipCreateStatus createStatus = MembershipService.CreateUser(userName, password, email);
                
                
                if (createStatus == MembershipCreateStatus.Success)
                {
                    //dodanie go do roli sprzedqawcy
                    Roles.AddUserToRole(userName, "Sprzedawca");


                    //tworzenie nowego sprzedawcy
                    Sprzedawca sp = new Sprzedawca();
                    sp.Imie = imie;
                    sp.Nazwisko = nazwisko;
                    sp.Stanowisko = stanowisko;
                    sp.NIP = nip;
                    sp.Login = userName;
                    sp.Rola_w_systemie = "sp";

                    db.AddToSprzedawca(sp);
                    db.SaveChanges();


//                    FormsAuth.SignIn(userName, false /* createPersistentCookie */);
                    return RedirectToAction("Index", "Admin");
                }
                else
                {
                    ModelState.AddModelError("_FORM", ErrorCodeToString(createStatus));
                }
            }

            // If we got this far, something failed, redisplay form
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Register(string imie, string nazwisko, string nip, string tel, string userName, string email, string password, string confirmPassword,
            string city,string citycode, string street, string streetNo)
        {

            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            if (ValidateRegistration(userName, email, password, confirmPassword, imie, nazwisko, nip, city, citycode, street, streetNo, tel))
            {
                // Attempt to register the user
                MembershipCreateStatus createStatus = MembershipService.CreateUser(userName, password, email);

                if (createStatus == MembershipCreateStatus.Success)
                {
                    //ustawienie go jako klienta
                    Roles.AddUserToRole(userName, "Klient");

                    //tworzenie nowego klienta
                    Klinet kl = new Klinet();
                    kl.Imie = imie;
                    kl.Nazwisko = nazwisko;
                    kl.E_Mail = email;
                    kl.NIP = nip;
                    kl.Telefon = tel;
                    kl.Login = userName;
                    kl.Rola_w_systemie = "kl";
                    db.AddToKlinet(kl);
                    db.SaveChanges();

                    var nrk = (from p in db.Klinet
                               where p.NIP == nip
                               select p.NrKlienta
                               ).First();
                    
                    //tworzenie adresu
                    Adres ad = new Adres();
                    ad.Kod = citycode;
                    ad.Miasto = city;
                    ad.NrDomu = streetNo;
                    ad.Ulica = street;
                    ad.NrKlienta = nrk;
                    db.AddToAdres(ad);
                    db.SaveChanges();


                    FormsAuth.SignIn(userName, false /* createPersistentCookie */);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("_FORM", ErrorCodeToString(createStatus));
                }
            }

            // If we got this far, something failed, redisplay form
            return View();
        }

        [Authorize]
        public ActionResult ChangePassword()
        {

            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            return View();
        }

        [Authorize]
        [AcceptVerbs(HttpVerbs.Post)]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1031:DoNotCatchGeneralExceptionTypes",
            Justification = "Exceptions result in password not being changed.")]
        public ActionResult ChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {

            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;

            if (!ValidateChangePassword(currentPassword, newPassword, confirmPassword))
            {
                return View();
            }

            try
            {
                if (MembershipService.ChangePassword(User.Identity.Name, currentPassword, newPassword))
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("_FORM", "The current password is incorrect or the new password is invalid.");
                    return View();
                }
            }
            catch
            {
                ModelState.AddModelError("_FORM", "The current password is incorrect or the new password is invalid.");
                return View();
            }
        }

        public ActionResult ChangePasswordSuccess()
        {

            return View();
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.User.Identity is WindowsIdentity)
            {
                throw new InvalidOperationException("Windows authentication is not supported.");
            }
        }

        #region Validation Methods

        private bool ValidateChangePassword(string currentPassword, string newPassword, string confirmPassword)
        {
            if (String.IsNullOrEmpty(currentPassword))
            {
                ModelState.AddModelError("currentPassword", "You must specify a current password.");
            }
            if (newPassword == null || newPassword.Length < MembershipService.MinPasswordLength)
            {
                ModelState.AddModelError("newPassword",
                    String.Format(CultureInfo.CurrentCulture,
                         "You must specify a new password of {0} or more characters.",
                         MembershipService.MinPasswordLength));
            }

            if (!String.Equals(newPassword, confirmPassword, StringComparison.Ordinal))
            {
                ModelState.AddModelError("_FORM", "The new password and confirmation password do not match.");
            }

            return ModelState.IsValid;
        }

        private bool ValidateLogOn(string userName, string password)
        {
            if (String.IsNullOrEmpty(userName))
            {
                ModelState.AddModelError("username", "You must specify a username.");
            }

            if (userName.Length < MembershipService.MinUserNameLength || userName.Length > MembershipService.MaxUserNameLength)
            {
                ModelState.AddModelError("username", "Nazwa użytkownika powinna mieć od 6 do 20 znaków");
            }

            if (!Regex.IsMatch(userName, "^[a-zA-Z0-9]+$"))
            {
                ModelState.AddModelError("username", "Nazwa użytkownika zawiera niewłaściwe znaki");
            }

            if (String.IsNullOrEmpty(password))
            {
                ModelState.AddModelError("password", "You must specify a password.");
            }

            if (password.Contains('\"') || password.Contains('\'') || password.Contains(' '))
            {
                ModelState.AddModelError("_FORM", "Hasło zawiera niewłaściwe znaki");
            }

            if (!MembershipService.ValidateUser(userName, password))
            {
                ModelState.AddModelError("_FORM", "Podana nazwa użytkownika lub hasło jest niewłaściwe");
            }

            return ModelState.IsValid;
        }

        private bool ValidateRegistration(string userName, string email, string password, string confirmPassword, string imie, string nazwisko, string nip, string city, string citycode, string street, string streetNo, string tel)
        {
            if (String.IsNullOrEmpty(userName))
            {
                ModelState.AddModelError("username", "Nie podano nazwy użytkownika");
            }

            if (userName.Length < MembershipService.MinUserNameLength || userName.Length > MembershipService.MaxUserNameLength)
            {
                ModelState.AddModelError("username", "Nazwa użytkownika powinna mieć od 6 do 20 znaków");
            }

            if (!Regex.IsMatch(userName, "^[a-zA-Z0-9]+$"))
            {
                ModelState.AddModelError("username", "Nazwa użytkownika zawiera niewłaściwe znaki");
            }

            if (String.IsNullOrEmpty(email) )
            {
                ModelState.AddModelError("email", "Nie podano adresu e-mail");
            }

            if (!Regex.IsMatch(email, "\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"))
            {
                ModelState.AddModelError("email", "Podany adres nie jest prawidłowym adresem e-mail");
            }

            //Nowe walidacje
            if (!Regex.IsMatch(nip, "^[0-9]{10}$"))
            {
                ModelState.AddModelError("nip", "NIP musi składać się z 10 cyfr");
            }

            if (!Regex.IsMatch(city, "^[A-Z]{1}[A-Za-z -]{0,19}$"))
            {
                ModelState.AddModelError("city", "Nazwa miasta jest nieprawidłowa");
            }

            if (!Regex.IsMatch(citycode, "^[0-9]{2}-[0-9]{3}$"))
            {
                ModelState.AddModelError("citycode", "Kod pocztowy jest nieprawidłowy");
            }

            if (!Regex.IsMatch(street, "^[A-Z]{1}[A-Za-z -]{0,19}$"))
            {
                ModelState.AddModelError("street", "Nazwa ulicy jest nieprawidłowa");
            }

            if (!Regex.IsMatch(streetNo, "^[0-9]{1}[0-9A-Za-z -]{0,19}$"))
            {
                ModelState.AddModelError("streetNo", "Numer ulicy jest nieprawidłowy");
            }

            if (!Regex.IsMatch(tel, "^[0-9 ()-]{6,20}$"))
            {
                ModelState.AddModelError("tel", "Numer telefonu nie jest prawidłowy");
            }

            if (!Regex.IsMatch(imie, "^[A-Z]{1}[A-Za-z -]{0,19}$"))
            {
                ModelState.AddModelError("imie", "Podanie imię nie jest prawidłowe");
            }

            if (!Regex.IsMatch(nazwisko, "^[A-Z]{1}[A-Za-z -]{0,19}$"))
            {
                ModelState.AddModelError("nazwisko", "Podanie nazwisko nie jest prawidłowe");
            }

            if (password == null || password.Length < MembershipService.MinPasswordLength)
            {
                ModelState.AddModelError("password",
                    String.Format(CultureInfo.CurrentCulture,
                         "Podane hasło jest za krótkie ( minimum {0} znaków )",
                         MembershipService.MinPasswordLength));
            }

            if (password.Contains('\"') || password.Contains('\'') || password.Contains(' ') )
            {
                ModelState.AddModelError("_FORM", "Hasło zawiera niewłaściwe znaki");
            }

            if (!String.Equals(password, confirmPassword, StringComparison.Ordinal))
            {
                ModelState.AddModelError("_FORM", "Podane hasła nie są identyczne");
            }
            return ModelState.IsValid;
        }

        private static string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://msdn.microsoft.com/en-us/library/system.web.security.membershipcreatestatus.aspx for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Username already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A username for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }
        #endregion
    }

    // The FormsAuthentication type is sealed and contains static members, so it is difficult to
    // unit test code that calls its members. The interface and helper class below demonstrate
    // how to create an abstract wrapper around such a type in order to make the AccountController
    // code unit testable.

    public interface IFormsAuthentication
    {
        void SignIn(string userName, bool createPersistentCookie);
        void SignOut();
    }

    public class FormsAuthenticationService : IFormsAuthentication
    {
        public void SignIn(string userName, bool createPersistentCookie)
        {
            FormsAuthentication.SetAuthCookie(userName, createPersistentCookie);
        }
        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
    }

    public interface IMembershipService
    {
        int MinPasswordLength { get; }
        int MaxPasswordLength { get; }

        int MinUserNameLength { get; }
        int MaxUserNameLength { get; }

        bool ValidateUser(string userName, string password);
        MembershipCreateStatus CreateUser(string userName, string password, string email);
        bool ChangePassword(string userName, string oldPassword, string newPassword);
    }

    public class AccountMembershipService : IMembershipService
    {
        private MembershipProvider _provider;

        public AccountMembershipService()
            : this(null)
        {
        }

        public AccountMembershipService(MembershipProvider provider)
        {
            _provider = provider ?? Membership.Provider;
        }

        public int MinPasswordLength
        {
            get
            {
                //return _provider.MinRequiredPasswordLength;
                return 6;
            }
        }

        public int MaxPasswordLength
        {
            get
            {
                return 20;
            }
        }

        public int MinUserNameLength
        {
            get
            {
                return 6;
            }
        }

        public int MaxUserNameLength
        {
            get
            {
                return 20;
            }
        }

        public bool ValidateUser(string userName, string password)
        {
            Debug.WriteLine("!!!!!!!!!!!Nazwa użytkownika: " + userName);
            Debug.WriteLine("!!!!!!!!!!!Hasło: " + password);

            return _provider.ValidateUser(userName, password);
        }

        public MembershipCreateStatus CreateUser(string userName, string password, string email)
        {
            MembershipCreateStatus status;
            _provider.CreateUser(userName, password, email, null, null, true, null, out status);
            return status;
        }

        public bool ChangePassword(string userName, string oldPassword, string newPassword)
        {
            MembershipUser currentUser = _provider.GetUser(userName, true /* userIsOnline */);
            return currentUser.ChangePassword(oldPassword, newPassword);
        }
    }
}
