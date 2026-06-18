---
title: Photos
layout: page
description: 'Some photos I took'
image:
nav-menu: true
gallery: true
permalink: /photos
---

<div id="main" class="alt">
  <section id="one">
    <div class="inner">
      <header class="major">
        <h1>Photos</h1>
      </header>

      <div class="gallery-masonry">
{% assign photo_count = 0 %}
{% assign _sorted = site.static_files | sort: "path" %}
{% for f in _sorted %}
  {% assign _p = f.path | split: "\" | join: "/" | downcase %}
  {% assign _ext = f.extname | downcase %}
  {% if _p contains 'assets/photos/' %}
    {% if _ext == '.jpg' or _ext == '.jpeg' or _ext == '.png' or _ext == '.gif' or _ext == '.webp' %}
      {% assign photo_count = photo_count | plus: 1 %}
      {% assign _src = f.path | split: "\" | join: "/" | relative_url %}
      {% assign _stem = f.name | replace: f.extname, "" %}
      {% assign _label = _stem | replace: "-", " " | replace: "_", " " %}
      <figure class="gallery-item">
        <button type="button" class="gallery-item__trigger" data-gallery-open data-full-src="{{ _src | xml_escape }}" data-caption="{{ _label | xml_escape }}" aria-label="View full size: {{ _label | xml_escape }}">
          <img class="gallery-item__img" src="{{ _src }}" alt="{{ _label | xml_escape }}" loading="lazy" decoding="async">
          <span class="gallery-item__title">{{ _label }}</span>
        </button>
      </figure>
    {% endif %}
  {% endif %}
{% endfor %}
      </div>

{% if photo_count == 0 %}
      <p class="gallery-empty">No photos found in <code>assets/photos/</code>. Add JPEG, PNG, GIF, or WebP files there and rebuild.</p>
{% endif %}

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
