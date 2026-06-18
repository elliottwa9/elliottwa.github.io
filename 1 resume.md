---
layout: page
title: Resumé
image: 
nav-menu: true
---

<style>
details > summary {
  font-size: 1.25em;
  padding: 0.75em 1em;
  cursor: pointer;
  list-style: none;
  border-radius: 4px;
}
details > summary::-webkit-details-marker { display: none; }
details > summary::before {
  content: '▶';
  display: inline-block;
  margin-right: 0.6em;
  transition: transform 0.3s ease;
  font-size: 0.85em;
}
details.is-open > summary::before {
  transform: rotate(90deg);
}
.resume-entry {
  padding: 0 1em 0 1.5em;
}
.resume-entry h3 {
  margin: 0;
}
.resume-entry p {
  margin: 0;
}
.resume-entry ul {
  margin-top: 0.25em;
  margin-bottom: 0;
}
</style>

<!-- Main -->
<div id="main" class="alt">
	<section id="one">
		<div class="inner">
			<header class="major">
				<h1>Resumé</h1>
			</header>

			<hr class="major" />

			<details>
				<summary><strong>Education</strong></summary>
				<div class="resume-entry">
					<h3>University of California, Irvine – School of Social Sciences</h3>
					<p><em>B.S., Business Economics · Expected Graduation: June 2027</em></p>
					<ul>
						<li><strong>Cumulative GPA:</strong> 3.7/4.0</li>
						<li><strong>Achievements:</strong> Dean's Honor List (Winter '25 – Present)</li>
						<li><strong>Relevant Coursework:</strong> Accounting, Intro to Financial Investments, Econometrics, Micro/Macroeconomics</li>
					</ul>
				</div>
			</details>

			<details>
				<summary><strong>Work Experience and Projects</strong></summary>
				<div class="resume-entry">
					<h3>Highland Dental Care</h3>
					<p><em>Dental Assistant · Jun 2024 – Sep 2024 · Bellevue, WA</em></p>
					<ul>
						<li>Managed patient intake and records for a high-volume private practice, handling sensitive information with accuracy and discretion in a detail-critical environment.</li>
						<li>Adhered to strict compliance and sterilization protocols, working independently to keep operations on schedule.</li>
					</ul>
				</div>
				<div class="resume-entry">
					<h3>Crate and Barrel</h3>
					<p><em>Seasonal Team Member · Sep 2023 – Dec 2023 · Bellevue, WA</em></p>
					<ul>
						<li>Processed high-volume transactions and purchase paperwork accurately during peak holiday season, maintaining attention to detail under pressure.</li>
						<li>Advised customers by translating detailed product specifications into clear recommendations, strengthening client communication and active-listening skills.</li>
					</ul>
				</div>
			</details>

			<details>
				<summary><strong>Activities and Leadership</strong></summary>
				<div class="resume-entry">
					<h3>McKinsey and Company</h3>
					<p><em>Forward Program Participant · Apr 2026 – Jun 2026 </em></p>
					<ul>
						<li>Selected for a competitive, multi-stage leadership program at McKinsey, building executive communication, structured thinking, and professional presence through curated workshops and coaching.</li>
						<li>Applied MECE-based issue trees and hypothesis-driven frameworks to break down ambiguous business problems, producing structured analyses across strategy and operations cases.</li>
					</ul>
				</div>
				<div class="resume-entry">
					<h3>UC Investments Academy</h3>
					<p><em>Member · Aug 2025 – Present </em></p>
					<ul>
						<li>Built practical exposure to institutional investment management, financial statement analysis, portfolio construction, and sustainable investing through hands-on case studies and guest lectures.</li>
						<li>Developed technical skills in valuation, Excel financial modeling, and scenario analysis through Training the Street workshops and The Forage virtual job simulations.</li>
					</ul>
				</div>
				<div class="resume-entry">
					<h3>180 Degrees UCI – Bain Case Competition Participant</h3>
					<p><em>Semifinalist · Apr 2026 · Irvine, CA</em></p>
					<ul>
						<li>Collaborated with 3 other members to create a report and presentation on Nike's Consumer Direct Offense (CDO) approach, providing analysis and future company direction recommendations.</li>
					</ul>
				</div>
				<div class="resume-entry">
					<h3>U.C. Irvine Lacrosse Club</h3>
					<p><em>Vice President &amp; Player · Sep 2024 – Present · Irvine, CA</em></p>
					<ul>
						<li>Directed financial planning and day-to-day operations as second-in-command, managing member dues, tracking expenses, and leading fundraising initiatives to keep the club financially self-sufficient.</li>
						<li>Managing the club's <a href="https://www.instagram.com/ucimenslacrosse/" target="_blank" rel="noopener noreferrer"> Instagram</a> presence and produced game-day photography and videography, growing engagement and visibility to support player recruiting and sponsorship outreach efforts.</li>
						<li><a href="https://mcla.us/articles/slc-division-iii-all-conference" target="_blank" rel="noopener noreferrer">2024-25</a> and <a href="https://mcla.us/articles/slc-shares-division-iii-all-conferences-awards" target="_blank" rel="noopener noreferrer">2025-26</a> <em>SLC First Team All-Conference</em> honors as a Long-Stick Midfielder.</li>
					</ul>
				</div>
			</details>

			<details>
				<summary><strong>Additional Information</strong></summary>
				<div class="resume-entry">
					<ul>
						<li><strong>Technical:</strong> Proficient in Excel, Google Sheets, PowerPoint. Working knowledge of Stata, Python</li>
						<li><strong>Certificates:</strong> Training the Street: <a href="https://app.diplomasafe.com/en-US/certificates/d04af07d5c46f5594469b404521449884040a1237" target="_blank" rel="noopener noreferrer">Introduction to Financial Modeling</a>; <a href="https://app.diplomasafe.com/en-US/certificates/d2bd31e0157d93aefd78d933c39d3614ac15bc181" target="_blank" rel="noopener noreferrer">Financial Statement Analysis</a></li>
						<li><strong>Languages:</strong> English (Native), Mandarin (Elementary Proficiency)</li>
						<li><strong>Interests:</strong> Lacrosse, Fantasy Football, Basketball, Movies, B&amp;W Photography</li>
					</ul>
				</div>
			</details>

			<hr class="major" />

		</div>
	</section>
</div>

<script>
const allDetails = Array.from(document.querySelectorAll('details'));

function closeDetails(d) {
  const w = d._wrapper;
  d.classList.remove('is-open');
  w.style.height = w.scrollHeight + 'px';
  requestAnimationFrame(() => {
    w.style.transition = 'height 0.35s ease';
    w.style.height = '0';
  });
  w.addEventListener('transitionend', () => {
    d.removeAttribute('open');
    w.style.transition = '';
    w.style.height = '';
  }, { once: true });
}

allDetails.forEach(details => {
  const summary = details.querySelector('summary');

  const wrapper = document.createElement('div');
  wrapper.style.overflow = 'hidden';
  Array.from(details.children).forEach(child => {
    if (child !== summary) wrapper.appendChild(child);
  });
  details.appendChild(wrapper);
  details._wrapper = wrapper;

  summary.addEventListener('click', e => {
    e.preventDefault();

    if (details.open) {
      closeDetails(details);
    } else {
      allDetails.forEach(other => { if (other.open) closeDetails(other); });
      details.setAttribute('open', '');
      details.classList.add('is-open');
      const fullHeight = wrapper.scrollHeight + 'px';
      wrapper.style.height = '0';
      requestAnimationFrame(() => {
        wrapper.style.transition = 'height 0.35s ease';
        wrapper.style.height = fullHeight;
      });
      wrapper.addEventListener('transitionend', () => {
        wrapper.style.transition = '';
        wrapper.style.height = '';
      }, { once: true });
    }
  });
});
</script>
