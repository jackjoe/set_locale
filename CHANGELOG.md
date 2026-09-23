## 0.4.3 (2026-09-23)
- Run `mix format`

## 0.4.2 (2026-09-23)
- Remove `excoveralls`: nothing posts to Coveralls. Use `mix test --cover` for a local coverage report

## 0.4.1 (2026-09-23)
- Allow gettext 1.0 (`~> 0.14 or ~> 1.0`). The previous `~> 0.14` requirement excluded 1.0
- Test against gettext 1.0.2: define the test backend with `Gettext.Backend` and move the fixtures to `LC_MESSAGES/*.po`

## 0.4.0 (2026-09-23)
- `plug_cowboy` is no longer a dependency. Apps that only got it through set_locale must add it themselves (or use Bandit)
- Develop and test against Phoenix 1.8. The `phoenix` requirement is unchanged

## 0.3.6 (2026-09-23)
- Remove the unused `earmark` dev dependency and bump `ex_doc` to 0.40, which uses `earmark_parser` itself

## 0.3.5 (2026-09-23)
- Replace the deprecated `use Mix.Config` with `import Config`

## 0.3.4 (2026-09-23)
- Drop the `locale` query param when redirecting, so `GET /?locale=nl` redirects to `/nl` instead of `/nl?locale=nl`. Other query params are kept in order

## 0.3.3 (2026-09-23)
- Fix tests for Plug 1.8+: pass `locale` as a route path param instead of a GET param, which the Plug test adapter now encodes into the query string

## 0.3.2 (2026-09-23)
- Replace the explicit `applications` list with `extra_applications` so runtime apps are inferred from deps. Fixes the `Phoenix.Controller.redirect/2 is undefined` warning on Elixir 1.15+
- Refresh mix.lock and bump hackney/ssl_verify_fun so the test deps compile on Elixir 1.15+

## 0.3.1 (2024-09-17)
- Add `:plug` to the runtime applications

## 0.3.0 (2024-09-17)
- Add `plug` and `plug_cowboy` as explicit dependencies

## 0.2.9 (2020-06-15)
- Bump requirements

## 0.2.8 (2019-11-13)
- Thanks @dirkholzapfel and @angelikatyborska for adding a whitelist option and fixing a failure when given an invalid locale

## 0.2.7 (2019-06-24)
- Thanks @mtarnovan and @angelikatyborska for fixing an issue when a cookie used a language that was not supported

## 0.2.6 (2019-02-21)
- Thanks @mtarnovan for fixing a compilation warning

## 0.2.5 (2019-02-21)
- Thanks @mtarnovan and @ohrite for relaxing the gettext and phoenix dependencies
- Thanks @narnach for making the locale stick and using the http referer header.
- bumped deps

## 0.2.4 (2017-09-28)
- Thanks @dirkholzapfel for bugfixing an accept-language header like "zh-Hans-CN;q=0.5"

## 0.2.3 (2017-09-28)
- Thanks @dirkholzapfel for adding fallback to "nl" if "nl-nl" is given in accept header
- reformatted code here and there
- bumped dependency versions


## 0.2.2 (2017-03-31)
bumped dependency versions

## 0.2.1 (2017-02-20)
bumped dependency versions

## 0.2.0 (2016-11-29)
Now also taking into account cookie settings for locale as suggested and initially written by @dirkholzapfel (Thank you!).
The current precedence and fallback chain is now :

- locale in url (i.e. /nl-nl/)
- cookie
- request headers accept-language
- default locale from config

This update contains a deprecation waring for the Plug config the new config is now :

```plug SetLocale, gettext: MyApp.Gettext, default_locale: "en-gb", cookie_key: "locale")```

The cookie key is optional, dont forget if you want to use this feature that you application actually stores the preferred locale on the cookie with the same key :)


## 0.1.3 (2016-11-25)
Including a bigfix by @dirkholzapfel which implement correct handling for URLs without given locale, Thanks !

## 0.1.2 (2016-11-07)
Support fallback of base language, for example a requested /en-gb/ can fallback to /en/

## 0.1.1 (2016-11-07)
Root paths not redirect to /en-gb in stead of /en-gb/

## 0.1.0 (2016-11-03)
  - Initial commit
