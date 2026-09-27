# Facets website

The current GitHub Pages site is served directly from `docs/`. Edit the four page fragments and historical post fragments in `_src/`, and the shared stylesheet in `assets/styles/site.css`, then run:

```sh
ruby docs/build.rb
```

Commit the generated HTML pages, including pages under `posts/`, with the source changes. The build uses only Ruby's standard library. `atom.xml` is a small static release feed and is edited directly.

The `.page`, `.post`, `brite.yml`, and `assets/layouts/` files are retained from the former Brite site for historical reference; they are not inputs to this build. The article copy in `_src/archive/` was taken from the original posts. It describes its original release period and should not be used as current installation or API guidance.
