---
title: Photos
layout: page
description: 'Some photos I took'
image:
nav-menu: true
gallery: true
permalink: /photos
---

<style>
#one > .inner {
  max-width: 100% !important;
  width: 100% !important;
  padding: 0 !important;
  margin: 0 !important;
}

.photos-layout {
  display: flex;
  min-height: calc(100vh - 5em);
}

.photos-sidebar {
  width: 200px;
  min-width: 200px;
  padding: 3em 2em;
  border-right: 1px solid rgba(255,255,255,0.1);
  position: sticky;
  top: 5em;
  height: calc(100vh - 5em);
  overflow-y: auto;
}

.category-link {
  display: block;
  padding: 0.4em 0;
  font-size: 0.95em;
  opacity: 0.5;
  transition: opacity 0.2s ease;
  cursor: pointer;
  color: inherit !important;
  border: none !important;
  text-decoration: none;
}

.category-link:hover,
.category-link.active {
  opacity: 1;
}

.photos-content {
  flex: 1;
  padding: 3em 2em;
  min-width: 0;
}

.category-section {
  display: none;
  opacity: 0;
}

.category-section.active {
  display: block;
  animation: categoryFadeIn 0.4s ease forwards;
}

@keyframes categoryFadeIn {
  from { opacity: 0; transform: translateY(6px); }
  to   { opacity: 1; transform: translateY(0); }
}

.category-section[data-category="sports"] .gallery-item__title {
  display: none;
}
</style>

{% assign _sorted = site.static_files | sort: "path" %}

{% comment %} Collect unique category names from subfolders {% endcomment %}
{% assign category_names = "" %}
{% for f in _sorted %}
  {% assign _p = f.path | split: "\" | join: "/" | downcase %}
  {% assign _ext = f.extname | downcase %}
  {% if _p contains 'assets/photos-web/' %}
    {% if _ext == '.jpg' or _ext == '.jpeg' or _ext == '.png' or _ext == '.gif' or _ext == '.webp' %}
      {% assign _after = _p | split: 'assets/photos-web/' | last %}
      {% assign _parts = _after | split: '/' %}
      {% if _parts.size >= 2 %}
        {% assign _cat = _parts[0] %}
        {% unless category_names contains _cat %}
          {% assign category_names = category_names | append: _cat | append: "|" %}
        {% endunless %}
      {% endif %}
    {% endif %}
  {% endif %}
{% endfor %}
{% assign cats = category_names | split: "|" %}

<div id="main" class="alt">
  <section id="one">
    <div class="inner">
      <div class="photos-layout">

        <aside class="photos-sidebar">
          {% for cat in cats %}
            {% assign _label = cat | replace: "-", " " | capitalize %}
            {% assign _label = _label | replace: "&amp;w", "&amp;W" | replace: "&w", "&W" %}
            <a href="#" class="category-link{% if forloop.first %} active{% endif %}" data-category="{{ cat }}">{{ _label }}</a>
          {% endfor %}
          {% if cats.size == 0 %}
            <p style="opacity:0.4; font-size:0.85em;">Create subfolders in <code>assets/photos-web/</code> to add categories.</p>
          {% endif %}
        </aside>

        <div class="photos-content">
          {% for cat in cats %}
            {% assign _first_cat = forloop.first %}
            <div class="category-section{% if _first_cat %} active{% endif %}" data-category="{{ cat }}">
              <div class="gallery-masonry">
                {% for f in _sorted %}
                  {% assign _p = f.path | split: "\" | join: "/" | downcase %}
                  {% assign _ext = f.extname | downcase %}
                  {% if _p contains 'assets/photos-web/' %}
                    {% if _ext == '.jpg' or _ext == '.jpeg' or _ext == '.png' or _ext == '.gif' or _ext == '.webp' %}
                      {% assign _after = _p | split: 'assets/photos-web/' | last %}
                      {% assign _parts = _after | split: '/' %}
                      {% if _parts.size >= 2 and _parts[0] == cat %}
                        {% assign _src = f.path | split: "\" | join: "/" | relative_url %}
                        {% assign _full_src = _src | replace: "photos-web", "photos" %}
                        {% assign _stem = f.name | replace: f.extname, "" %}
                        {% assign _label = _stem | replace: "-", " " | replace: "_", " " %}
                        <figure class="gallery-item">
                          <button type="button" class="gallery-item__trigger" data-gallery-open data-full-src="{{ _full_src | xml_escape }}" data-caption="{{ _label | xml_escape }}" aria-label="View full size: {{ _label | xml_escape }}">
                            <img class="gallery-item__img" src="{{ _src }}" alt="{{ _label | xml_escape }}" loading="{% if _first_cat %}eager{% else %}lazy{% endif %}" decoding="async">
                            <span class="gallery-item__title">{{ _label }}</span>
                          </button>
                        </figure>
                      {% endif %}
                    {% endif %}
                  {% endif %}
                {% endfor %}
              </div>
            </div>
          {% endfor %}
        </div>

      </div>
    </div>
  </section>
</div>

<div id="gallery-lightbox" class="gallery-lightbox" hidden data-gallery-lightbox>
  <div class="gallery-lightbox__backdrop" data-gallery-close tabindex="-1" aria-hidden="true"></div>
  <figure class="gallery-lightbox__figure">
    <button type="button" class="gallery-lightbox__close" data-gallery-close aria-label="Close">&times;</button>
    <img class="gallery-lightbox__img" src="" alt="">
    <figcaption class="gallery-lightbox__caption"></figcaption>
  </figure>
</div>

<script>
document.querySelectorAll('.category-link').forEach(function(link) {
  link.addEventListener('click', function(e) {
    e.preventDefault();
    var cat = this.dataset.category;
    var next = document.querySelector('.category-section[data-category="' + cat + '"]');
    var current = document.querySelector('.category-section.active');

    document.querySelectorAll('.category-link').forEach(function(l) { l.classList.remove('active'); });
    this.classList.add('active');

    // Kick off loading for the incoming section's images immediately
    // so they all race in parallel rather than loading top-to-bottom later
    if (next) {
      next.querySelectorAll('img[loading="lazy"]').forEach(function(img) {
        img.loading = 'eager';
      });
    }

    if (current && current !== next) {
      current.style.transition = 'opacity 0.25s ease';
      current.style.opacity = '0';
      setTimeout(function() {
        current.classList.remove('active');
        current.style.transition = '';
        current.style.opacity = '';
        if (next) next.classList.add('active');
      }, 250);
    } else if (next) {
      next.classList.add('active');
    }
  });
});
</script>
