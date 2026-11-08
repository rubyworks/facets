# Facets website

The GitHub Pages site is built by GitHub Pages' own Jekyll from `docs/` on the
main branch. There is no build step to run: push, and GitHub builds it.

- `_layouts/default.html` is the shared page shell, and `_layouts/post.html`
  wraps blog posts.
- `index.html`, `learn.html`, `news.html` and `source.html` are the main pages.
  Each starts with front matter giving its `title`, `description` and the nav
  item it marks `active`.
- `blog/index.html` lists the posts. Blog posts go in `_posts/`, named
  `YYYY-MM-DD-slug.md`, with a `title` and optionally a `subtitle` and
  `description` in their front matter. They're published at
  `posts/YYYY-MM-DD-slug.html`, and `feed.xml` is generated from them.
- The posts marked `archive: true` are preserved from the early Facets site.
  They describe their original release period and should not be used as
  current installation or API guidance.
- `assets/styles/site.css` is the stylesheet.
- `atom.xml` is a small static release feed and is edited directly.

To preview the site with the same Jekyll and plugins GitHub Pages uses, make a
Gemfile somewhere outside the repository containing
`gem 'github-pages', group: :jekyll_plugins` and `gem 'webrick'`, run
`bundle install` there, and then, from that directory:

```sh
bundle exec jekyll serve -s path/to/facets/docs -d /tmp/facets-site
```

The site is then at <http://localhost:4000/facets/>.

The `.page`, `.post`, `brite.yml` and `assets/layouts/` files are left from
the former Brite site for historical reference. `_config.yml` excludes them
from the build.
