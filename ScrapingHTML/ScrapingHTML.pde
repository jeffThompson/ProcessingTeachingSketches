import org.jsoup.safety.*;
import org.jsoup.examples.*;
import org.jsoup.helper.*;
import org.jsoup.*;
import org.jsoup.parser.*;
import org.jsoup.select.*;
import org.jsoup.nodes.*;

/*
BUILDING A WEB-SCRAPER
 Jeff Thompson
 March 2012
 
 Gathering data from the web by parsing the HTML source code is called
 "scraping".  Here we pull data from a Wikipedia page.
 
 <h2>
   <span class="mw-headline" id="See_also">See also</span>
 </h2>
 <ul>
   <li><a href="/wiki/HTML5" title="HTML5">HTML5</a></li>
   <li><a href="/wiki/Breadcrumb_(navigation)" title="Breadcrumb (navigation)">Breadcrumb (navigation)</a></li>
   <li><a href="/wiki/CSS" title="CSS" class="mw-redirect">CSS</a></li>
   <li><a href="/wiki/Dynamic_web_page" title="Dynamic web page">Dynamic web page</a></li>
   <li><a href="/wiki/HTML_decimal_character_rendering" title="HTML decimal character rendering">HTML decimal character rendering</a></li>
   <li><a href="/wiki/HTTP" title="HTTP" class="mw-redirect">HTTP</a></li>
   <li><a href="/wiki/List_of_document_markup_languages" title="List of document markup languages">List of document markup languages</a></li>
   <li><a href="/wiki/Microformat" title="Microformat">Microformat</a></li>
   <li><a href="/wiki/SGML" title="SGML" class="mw-redirect">SGML</a></li>
   <li><a href="/wiki/XML" title="XML">XML</a></li>
 </ul>
 
 We're using JSoup for parsing - see the ParsingHTML_WithJSoup tutorial
 for more info on how this works; download the current .jar file from: 
 http://jsoup.org/download
 
 www.jeffreythompson.org
 */

// stock to look up (below is Google)
String url = "http://en.wikipedia.org/wiki/Html";

void setup() {

  // load source code for the page
  String[] source = loadStrings(url);

  String currentPrice = "";

  // for more information on what's happening here, see the ParseHTML_WithJSoup.pde example...
  for (int i=0; i<source.length; i++) {

    // load the of source code into a Document object
    Document doc = Jsoup.parse(source[i]);

    // look for the class time_rtq_ticker, this contains the current stock price
    Elements results = doc.select("span#See_also, ul, li");

    // while there should only be one result, use a for loop to retrieve the result
    for (Element price : results) {
      currentPrice = price.html();
      println(currentPrice);
    }
  }
  exit();
}

