If you are having problems cloning `https://github.com/Digital-Grinnell/dg-isle` or `https://github.com/Digital-Grinnell/dg-islandora` there are two possible problems:

  - The _Keychain Access_ app has cached inappropriate GitHub credentials and subsequently won't allow proper authentication, or
  - You entered the wrong GitHub credentials. In this case, you need to email digital@grinnell.edu and ask for proper credentials to enter.

To correct _Keychain Access_, see [Easily Change GitHub User in OSX](https://static.grinnell.edu/blogs/McFateM/posts/055-easily-change-github-user-in-osx/) or just try the following:

  - In Finder, search for the _Keychain Access_ app.
  - In _Keychain Access_, search for github.com.
  - Find the “Internet password” entry for `github.com`.
  - Delete the entry.

The next git... command you specify will prompt you for a GitHub username and password – or if 2-factor authentication is enabled, a Personal Access Token – and those are automatically saved in _Keychain Access_ until you repeat the above process.
