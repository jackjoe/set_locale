# SetLocale

A Phoenix plug for locale-prefixed URLs such as `https://www.example.org/nl/foo/bar`.

SetLocale reads the locale from the URL. If your Gettext backend supports it, the plug assigns it to `conn.assigns.locale` and sets it as the Gettext locale. If the URL has no locale, or one that isn't supported, the plug redirects to the same path with a supported locale prefix.

This repository continues [smeevil/set_locale](https://github.com/smeevil/set_locale) by Gerard de Brieder. The `set_locale` package on Hex stops at 0.2.9, so install newer versions from GitHub.

## Installation

Add `set_locale` to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:set_locale, "~> 0.4.0", github: "jackjoe/set_locale"}
  ]
end
```

Mix checks the version requirement against the version on `master`, so a breaking release such as 0.5.0 fails to compile instead of arriving silently with `mix deps.update`.

## Setup

Add the plug to your browser pipeline and put your routes in a `/:locale` scope:

```elixir
defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # ...

    plug SetLocale,
      gettext: MyAppWeb.Gettext,
      default_locale: "en",
      # optional
      cookie_key: "preferred_locale",
      additional_locales: ["fr", "es"]
  end

  scope "/", MyAppWeb do
    pipe_through :browser

    # "/" needs a route. SetLocale always redirects it, so this action never runs.
    get "/", PageController, :dummy
  end

  scope "/:locale", MyAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    # ...
  end
end
```

### Options

- `gettext` (required): your Gettext backend.
- `default_locale` (required): the locale to use when no other source gives a supported one.
- `cookie_key` (optional): the name of a cookie that holds the user's preferred locale. SetLocale only reads this cookie; your app has to set it.
- `additional_locales` (optional): locales to accept in URLs even though Gettext doesn't know them, for example when a translation service handles them in the browser. For these locales `conn.assigns.locale` holds the URL locale and Gettext is set to `default_locale`.

## Examples

With `default_locale: "en"`, Gettext locales `en` and `nl`, and no cookie:

| Request | Result |
|---|---|
| `/` | redirect to `/en` |
| `/foo/bar` | redirect to `/en/foo/bar` |
| `/nl/foo/bar` | no redirect, `conn.assigns.locale` is `"nl"` |
| `/nl-be/foo/bar` | redirect to `/nl/foo/bar` |
| `/de-de/foo/bar` | redirect to `/en/foo/bar` |
| `/foo/bar` with `Accept-Language: nl-BE` | redirect to `/nl/foo/bar` |
| `/foo/bar` with `Referer: https://www.example.org/nl/about` | redirect to `/nl/foo/bar` |
| `/foo?page=2` | redirect to `/en/foo?page=2` |
| `/?locale=nl` | redirect to `/nl` |

Redirects keep the query string, except for a `locale` parameter.

## How the locale is chosen

A supported locale in the URL is used as is. If only its base language is supported, SetLocale redirects to that: `/nl-be/foo` becomes `/nl/foo` when you support `nl` but not `nl-be`.

Otherwise SetLocale checks these sources in order:

1. the cookie named by `cookie_key`
2. the locale prefix of the `Referer` URL, the page the user came from
3. the `Accept-Language` header; for an entry such as `nl-BE` it also tries `nl`
4. `default_locale`

The cookie and the `Referer` are taken as they are. If the first of them that holds a locale holds an unsupported one, SetLocale uses `default_locale` without checking the later sources.

## Locale names

URL locales are two lowercase letters, optionally followed by a hyphen and two more: `nl`, `en-gb`. SetLocale compares them with `Gettext.known_locales/1`, so your Gettext locale directories need the same names: `priv/gettext/en-gb`, not `priv/gettext/en_GB`. A path segment in another format isn't treated as a locale, so `/en_GB/foo` redirects to `/en/en_GB/foo`.

Gettext has no plural rules for hyphenated names such as `en-gb`, and raises `Gettext.Plural.UnknownLocaleError` when it compiles a `.po` file for one without a `Plural-Forms` header. Add the header to those files:

```
msgid ""
msgstr ""
"Language: en-gb\n"
"Plural-Forms: nplurals=2; plural=(n != 1);\n"
```
