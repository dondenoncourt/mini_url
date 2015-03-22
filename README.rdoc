== README

Requirements:

Implementation of a simple Rails web service that has the following behaviors:

  *   Given a long URL, it will provide a short URL that is 6 URL save base64 characters long
  *   Given a short URL that it generated, it will provide the corresponding long URL
  *   Short URLs are likely to be transcribed by hand, so this implementation always provides short URLs with o, b, and l rather than 0, 6, and 1. Also, should a short URL with 0, 6, or 1s be passed to the GET, those characters will be replaced with their alphabetical equivalents.
  *   On the other hand, transcription errors should ideally not result in false results. The short URLspace should be sparse, specifically having the property that no two short URLs should differ by only one character.
Bonus Round
The hallmark of a good design is how well it adapts to changing requirements. If you have the time and inclination, you might expand on the requirements with other sensible ideas, e.g.:

  *   Short URLs must not contain any string in a list of inappropriate words. The list should be stubbed as "foo" and "bar" while legal trawls 4chan and compiles a master list of terms calculated to give offense.

