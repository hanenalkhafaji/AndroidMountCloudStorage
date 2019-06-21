### Standard authorization mode

Authorization is provided by a Google App Engine service (the source code of
the service is [here](https://github.com/astrada/gd-ocaml-auth)). When you
start the program without specifying a mountpoint,

    $ google-drive-ocamlfuse

the executable opens a web browser (using `xdg-open`, or, if `xdg-open` is not
available, launching `firefox` or `google-chrome`), showing a page that will
ask you to authorize access to your Google Drive. If you allow it, the Google
authorization endpoint will connect to the GAE service, providing a
verification code, that will be exchanged for an access token and a refresh
token (for offline access). Meanwhile, `google-drive-ocamlfuse` polls the GAE
service, asking for tokens, until it gets them, or there is an error, or a
timeout triggers. You might need to close the browser for the executable to continue its operation. If anything goes wrong, you can safely restart the
application, and it will try to recover. If it cannot recover, you should
clean the content of `~/.gdfuse/default` to start from scratch. Otherwise, if
the application can retrieve the tokens, the program will exit and you may
then mount the Google Drive filesystem. `google-drive-ocamlfuse` will also use
the GAE service when it needs to refresh the access token (access tokens
usually are valid for 60 minutes). The GAE service has two purposes: to make
the authorization process simpler (removing all manual steps), and to avoid
exposing the OAuth2 client secret of the application (otherwise anyone can
impersonate it).

### Alternative authorization mode

If you don't trust the GAE service, there is an alternative way to authorize
the application, that doesn't involve external services. If you have your own
OAuth2 client ID and client secret, you may pass them on the command line (the
first time you issue the application), e.g.:

    $ google-drive-ocamlfuse -id 12345678.apps.googleusercontent.com -secret abcde12345

This way, the application will use your credentials, and will not connect to
the GAE service. A browser will be started pointing to an authorization page,
and when you allow access to Google Drive, a verification code will be
generated. You have to copy this verification code, and paste it in the
console where the application is running.

    Please enter the verification code: 1/12309afhaskfhlskhfklsfslkhfskhfskskdfh

If everything goes fine, the application will notify you that it has retrieved
the tokens from Google.

    Access token retrieved correctly.

You can create OAuth2 credentials from the Google APIs Console. [Here](https://developers.google.com/console/help/new/#creatingdeletingprojects) you can find how to create a new application and [here](https://developers.google.com/console/help/new/#setting-up-oauth-20) how to set up OAuth 2.0 credentials. When [activating APIs](https://developers.google.com/console/help/new/#activating-and-deactivating-apis), you must select the Drive API. When creating a new client ID, you must select "Installed applications" as Application type and "Other" as Installed application type (Redirect URI should be `urn:ietf:wg:oauth:2.0:oob`). Check that Drive API is among the Enabled APIs of your [Developers Console](https://console.developers.google.com/project/_/apiui/apis/library).

### Revoking access

Anyway, you can always revoke access to Google Drive from
[here](https://security.google.com/settings/security/permissions?pli=1).

