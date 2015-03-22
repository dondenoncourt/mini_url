# Implementation of a simple Rails URL Shortener web service

  *   Given a long URL, it will provide a short URL that is 8 characters (URL safe base64) long
  *   Given a short URL that it generated, it will provide the corresponding long URL
  *   Short URLs are likely to be transcribed by hand, so this
implementation always provides short URLs with o, b, and l rather than
0, 6, and 1. Also, should a short URL with 0, 6, or 1s be passed to the
GET, those characters will be replaced with their alphabetical
equivalents. In that manner, false results should not be returned.
  *   The generated mini url will not contain bad words (specifically "foo" and "bar", pardon my French)
  *   Mini URLs are created from the page displayed from the ROOT URL of the application
  *   The RESTful API will take GET requests of either the id of the
MiniUrl SQL row or the mini_url itself. So, for example, the following
2 URLs would pull the same information:
  **   http://localhost:3000/short_urls/pau_gwaq
  **   http://localhost:3000/short_urls/5
  * note that, for convience, the mini url in the root path will return
results:
  **   http://localhost:3000/pau_gwaq
  * By placing a format type of JSON, you will receive a JSON response:
  ** http://ocalhost:3000/pau_gwaq.json or http://ocalhost:3000/5.json
```JSON
{
id: 5,
url: "smith.com",
mini_url: "pau_gwaq.com",
created_at: "2015-03-22T20:30:25.330Z",
updated_at: "2015-03-22T20:30:25.330Z"
}
```
  * update and capabilities are not available in the API 
  

