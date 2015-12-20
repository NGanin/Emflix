<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="xsl xs">
    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

    <xsl:template match="/*">
        <xsl:result-document method="html" href="nav.php">
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <meta charset="UTF-8"/>
            <meta name="Keywords"
                content="Emerson College, Circulating Media, Iwasaki Library, Media Collection, Netflix, DVD"/>
            <meta name="Author" content="Netanel Ganin"/>
            <link rel="stylesheet" type="text/css" href="../../CssJs/FullSiteTest.css"/>
            <link href="http://fonts.googleapis.com/css?family=Oswald" rel="stylesheet"
                type="text/css"/>
            <xsl:text disable-output-escaping="yes">&lt;/head&gt;</xsl:text>
            <xsl:text disable-output-escaping="yes">&lt;body&gt;</xsl:text>
            <xsl:text disable-output-escaping="yes">&lt;div id="page"&gt;</xsl:text>
            <header role="banner">
                <nav role="navigation">
                    <div class="logo">
                        <a href="../../GenrePHP/index/index.php">EMFLIX</a>
                    </div>
                    <ul class="linkWrapper">
                        <li>
                            <button type="button" class="onclick-menu omOne" id="browse"
                                tabindex="1">Browse</button>
                            <div class="onclick-menu-content omcOne" id="omcOne">
                                <div class="col">
                                    <ul>
                                        <xsl:for-each-group select="*" group-by="genreWrap/genre">
                                            <xsl:sort select="current-grouping-key()"/>
                                            <xsl:if test="position() &lt; 6">
                                                <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate(current-grouping-key(),' ',''))}/{lower-case(translate(current-grouping-key(),' ',''))}.php">
                                                  <xsl:value-of select="current-grouping-key()"/>
                                                  </a>
                                                </li>
                                            </xsl:if>
                                        </xsl:for-each-group>
                                    </ul>
                                </div>
                                <div class="col">
                                    <ul>
                                        <xsl:for-each-group select="*" group-by="genreWrap/genre">
                                            <xsl:sort select="current-grouping-key()"/>
                                            <xsl:if test="position() > 5 and position() &lt; 11">
                                                <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate(current-grouping-key(),' ',''))}/{lower-case(translate(current-grouping-key(),' ',''))}.php">
                                                  <xsl:value-of select="current-grouping-key()"/>
                                                  </a>
                                                </li>
                                            </xsl:if>
                                        </xsl:for-each-group>
                                    </ul>
                                </div>
                                <div class="col">
                                    <ul>
                                        <xsl:for-each-group select="*" group-by="genreWrap/genre">
                                            <xsl:sort select="current-grouping-key()"/>
                                            <xsl:if test="position() > 10 and position() &lt; 16">
                                                <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate(current-grouping-key(),' ',''))}/{lower-case(translate(current-grouping-key(),' ',''))}.php">
                                                  <xsl:value-of select="current-grouping-key()"/>
                                                  </a>
                                                </li>
                                            </xsl:if>
                                        </xsl:for-each-group>
                                    </ul>
                                </div>
                                <div class="col">
                                    <ul>
                                        <xsl:for-each-group select="*" group-by="genreWrap/genre">
                                            <xsl:sort select="current-grouping-key()"/>
                                            <xsl:if test="position() > 15">
                                                <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate(current-grouping-key(),' ',''))}/{lower-case(translate(current-grouping-key(),' ',''))}.php">
                                                  <xsl:value-of select="current-grouping-key()"/>
                                                  </a>
                                                </li>
                                            </xsl:if>
                                        </xsl:for-each-group>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li class="navLink">
                            <a href="../../GenrePHP/index/faq.php">FAQ</a>
                        </li>
                        <li class="navLink">
                            <a href="../../GenrePHP/index/feedback.php">Feedback</a>
                        </li>
                        <li class="navLink">
                            <a href="../../GenrePHP/index/new.php">New Items</a>
                        </li>
                        <li class="navLink">
                            <a href="../../GenrePHP/index/genreMap.php">Genre Map</a>
                        </li>
                    </ul>
                    <form class="search" action="../../GenrePHP/index/search.php" method="get">
                        <input type="search" name="searchTerm"
                            placeholder="Search here" results="0"/>
                    </form>
                </nav>
            </header>
        </xsl:result-document>




        <xsl:for-each-group select="*" group-by="genreWrap/genre">

            <xsl:variable name="genreDoc" select="current-grouping-key()"/>

            <xsl:result-document method="html"
                href="GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($genreDoc,' ',''))}.php">
                <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
                <html lang="en">
                    <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                    <title>
                        <xsl:value-of select="$genreDoc"/>
                    </title>
                    <xsl:processing-instruction name="php">
                            include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                    <div id="inner">
                        <div class="subheader">
                            <h1>
                                <xsl:value-of select="$genreDoc"/>
                            </h1>
                            <button type="button" class="onclick-menu omTwo" id="subgenre"
                                tabindex="2">Subgenres<span class="arrow"/></button>
                            <div class="onclick-menu-content omcTwo">
                                <ul class="col">
                                    <xsl:for-each-group
                                        select="current-group()/genreWrap[genre = $genreDoc]"
                                        group-by="subGenre">
                                        <xsl:sort select="current-grouping-key()"/>
                                        <xsl:variable name="subGenre"
                                            select="current-grouping-key()"/>
                                        <xsl:if test="position() &lt; 11">
                                            <li>
                                                <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subGenre"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each-group>
                                </ul>
                                <ul class="col">
                                    <xsl:for-each-group
                                        select="current-group()/genreWrap[genre = $genreDoc]"
                                        group-by="subGenre">
                                        <xsl:sort select="current-grouping-key()"/>
                                        <xsl:variable name="subGenre"
                                            select="current-grouping-key()"/>
                                        <xsl:if test="position() > 10 and position() &lt; 21">
                                            <li>
                                                <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subGenre"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each-group>
                                </ul>
                                <ul class="col">
                                    <xsl:for-each-group
                                        select="current-group()/genreWrap[genre = $genreDoc]"
                                        group-by="subGenre">
                                        <xsl:sort select="current-grouping-key()"/>
                                        <xsl:variable name="subGenre"
                                            select="current-grouping-key()"/>
                                        <xsl:if test="position() > 20 and position() &lt; 31">
                                            <li>
                                                <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subGenre"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each-group>
                                </ul>
                                <ul class="col">
                                    <xsl:for-each-group
                                        select="current-group()/genreWrap[genre = $genreDoc]"
                                        group-by="subGenre">
                                        <xsl:sort select="current-grouping-key()"/>
                                        <xsl:variable name="subGenre"
                                            select="current-grouping-key()"/>
                                        <xsl:if test="position() > 30">
                                            <li>
                                                <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subGenre"/>
                                                </a>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each-group>
                                </ul>

                            </div>
                            <hr/>
                        </div>
                        <xsl:variable name="sorted-group">
                            <xsl:for-each select="current-group()">
                                <xsl:sort
                                    select="upper-case(substring(title[not(@type) or ../self::*[count(title) = 1]]/concat(.,@differentiator),if (title/@sort) then (title/@sort) else 1))"/>
                                <xsl:copy-of select="."/>
                            </xsl:for-each>
                        </xsl:variable>

                        <xsl:for-each select="$sorted-group/*">
                            <xsl:apply-templates select="." mode="movie"/>
                        </xsl:for-each>
                    </div>
                    <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                    <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
                    <xsl:for-each-group select="current-group()/genreWrap[genre = $genreDoc]"
                        group-by="subGenre">
                        <xsl:variable name="subGenreDoc" select="current-grouping-key()"/>
                        <xsl:result-document method="html"
                            href="GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subGenreDoc,' ',''))}.php">
                            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
                            <html lang="en">
                                <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                                <title>
                                    <xsl:value-of select="$subGenreDoc"/>
                                </title>

                                <xsl:processing-instruction name="php">
                        include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                                <div id="inner">
                                    <div class="subheader">
                                        <h2>
                                            <a
                                                href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($genreDoc,' ',''))}.php">
                                                <xsl:value-of select="$genreDoc"/>
                                            </a>
                                        </h2>
                                        <h1>
                                            <xsl:value-of select="$subGenreDoc"/>
                                        </h1>
                                        <xsl:if
                                            test="current-group()/subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenreDoc]]">
                                            <button type="button" class="onclick-menu omTwo"
                                                id="subgenre" tabindex="2">Subgenres<span
                                                  class="arrow"/></button>
                                            <div class="onclick-menu-content omcTwo">
                                                <ul class="col">
                                                  <xsl:for-each-group
                                                  select="current-group()/subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenreDoc]]"
                                                  group-by=".">
                                                  <xsl:sort select="current-grouping-key()"/>
                                                  <xsl:variable name="subSubGenre"
                                                  select="current-grouping-key()"/>
                                                  <xsl:if test="position() &lt; 11">
                                                  <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subSubGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subSubGenre"/>
                                                  </a>
                                                  </li>
                                                  </xsl:if>
                                                  </xsl:for-each-group>
                                                </ul>
                                                <ul class="col">
                                                  <xsl:for-each-group
                                                  select="current-group()/subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenreDoc]]"
                                                  group-by=".">
                                                  <xsl:sort select="current-grouping-key()"/>
                                                  <xsl:variable name="subSubGenre"
                                                  select="current-grouping-key()"/>
                                                  <xsl:if
                                                  test="position() > 10 and position() &lt; 21">
                                                  <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subSubGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subSubGenre"/>
                                                  </a>
                                                  </li>
                                                  </xsl:if>
                                                  </xsl:for-each-group>
                                                </ul>
                                                <ul class="col">
                                                  <xsl:for-each-group
                                                  select="current-group()/subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenreDoc]]"
                                                  group-by=".">
                                                  <xsl:sort select="current-grouping-key()"/>
                                                  <xsl:variable name="subSubGenre"
                                                  select="current-grouping-key()"/>
                                                  <xsl:if
                                                  test="position() > 20 and position() &lt; 31">
                                                  <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subSubGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subSubGenre"/>
                                                  </a>
                                                  </li>
                                                  </xsl:if>
                                                  </xsl:for-each-group>
                                                </ul>
                                                <ul class="col">
                                                  <xsl:for-each-group
                                                  select="current-group()/subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenreDoc]]"
                                                  group-by=".">
                                                  <xsl:sort select="current-grouping-key()"/>
                                                  <xsl:variable name="subSubGenre"
                                                  select="current-grouping-key()"/>
                                                  <xsl:if test="position() > 30">
                                                  <li>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subSubGenre,' ',''))}.php">
                                                  <xsl:value-of select="$subSubGenre"/>
                                                  </a>
                                                  </li>
                                                  </xsl:if>
                                                  </xsl:for-each-group>
                                                </ul>
                                            </div>
                                        </xsl:if>
                                        <hr/>
                                    </div>
                                    <xsl:variable name="sorted-group">
                                        <xsl:for-each select="current-group()/..">
                                            <xsl:sort
                                                select="upper-case(substring(title[not(@type) or ../self::*[count(title) = 1]]/concat(.,@differentiator),if (title/@sort) then (title/@sort) else 1))"/>
                                            <xsl:copy-of select="."/>
                                        </xsl:for-each>
                                    </xsl:variable>

                                    <xsl:for-each select="$sorted-group/*">
                                        <xsl:apply-templates select="." mode="movie"/>
                                    </xsl:for-each>
                                </div>
                                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                                <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>

                                <xsl:for-each-group
                                    select="current-group()/../genreWrap[genre=$genreDoc][subGenre=$subGenreDoc]"
                                    group-by="subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenreDoc]]">
                                    <xsl:sort select="current-grouping-key()"/>
                                    <xsl:variable name="subSubGenreDoc"
                                        select="current-grouping-key()"/>
                                    <xsl:result-document method="html"
                                        href="GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subSubGenreDoc,' ',''))}.php">
                                        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
                                        <html lang="en">
                                            <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                                            <xsl:processing-instruction name="php">
                                            include '../../nav.php';<xsl:text>?</xsl:text>
                                            </xsl:processing-instruction>
                                            <div id="inner">
                                                <div class="subheader">
                                                  <h3>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($genreDoc,' ',''))}.php">
                                                  <xsl:value-of select="$genreDoc"/>
                                                  </a>
                                                  </h3>
                                                  <h2>
                                                  <a
                                                  href="../../GenrePHP/{lower-case(translate($genreDoc,' ',''))}/{lower-case(translate($subGenreDoc,' ',''))}.php">
                                                  <xsl:value-of select="$subGenreDoc"/>
                                                  </a>
                                                  </h2>
                                                  <h1>
                                                  <xsl:value-of select="$subSubGenreDoc"/>
                                                  </h1>
                                                  <hr/>
                                                </div>
                                                <xsl:variable name="sorted-group">
                                                  <xsl:for-each select="current-group()/..">
                                                  <xsl:sort
                                                  select="upper-case(substring(title[not(@type) or ../self::*[count(title) = 1]],if (title/@sort) then (title/@sort) else 1))"/>
                                                  <xsl:copy-of select="."/>
                                                  </xsl:for-each>
                                                </xsl:variable>

                                                <xsl:apply-templates select="$sorted-group/*"
                                                  mode="movie"/>

                                            </div>
                                            <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                                            <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
                                        </html>
                                    </xsl:result-document>
                                </xsl:for-each-group>

                            </html>
                        </xsl:result-document>
                    </xsl:for-each-group>
                </html>
            </xsl:result-document>
        </xsl:for-each-group>
        <xsl:apply-templates select="/*" mode="index"/>
    </xsl:template>



    <xsl:template match="/*" mode="index">
        
        <xsl:result-document method="html" href="GenrePHP/index/index.php">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="en">
                <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                <title>
                    <xsl:text>Home</xsl:text>
                </title>
                <xsl:processing-instruction name="php">
                        include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                <div id="inner" class="index">
                    <script>
                        if ( navigator.userAgent.indexOf('Macintosh') > -1 &amp;&amp; navigator.userAgent.indexOf('Chrome') == -1){
                            if ( navigator.userAgent.indexOf('Safari') > -1) {
                            document.write("&lt;div class=&apos;error&apos;><p>Greetings Safari user on a Mac! You've found a bug I'm working on. You can only activate the 'Browse' button and the 'Subgenre' buttons using the TAB key on your keyboard. If you haven't done so, you'll have to activate tabbing under Safari - Preferences - Advanced - Accessibility. (Or you could switch to Chrome...)</p>&lt;/div>");
                        }
                            if ( navigator.userAgent.indexOf('Firefox') > -1) {
                            document.write("&lt;div class=&apos;error&apos;><p>Greetings Firefox user on a Mac! You've found a bug I'm working on. You can only activate the 'Browse' button and the 'Subgenre' buttons using the TAB key on your keyboard. (Or you could switch to Chrome...)</p>&lt;/div>");
                        }
                            }
                    </script>
                    <div class="welcome">
                        <p>Welcome to the brand-new interface for the circulating media collection
                            at the Emerson College Library!</p>
                        <p>Hop over to "browse" to get started, or try searching in the search bar!</p>
                    </div>

                    <xsl:for-each-group select="media" group-by="@dateCreated">
                        <xsl:sort order="descending" select="current-grouping-key()"/>
                        <xsl:if test="position() = 1">
                            <div id="container">
                                <div id="slider">
                                    <!-- Slider container -->
                                    <div id="mask">
                                        <!-- Mask -->
                                        <ul>
                                            <xsl:apply-templates
                                                select="current-group()[position() = 1]"
                                                mode="first"/>
                                            <xsl:apply-templates
                                                select="current-group()[position() = 2]"
                                                mode="second"/>
                                            <xsl:apply-templates
                                                select="current-group()[position() = 3]"
                                                mode="third"/>
                                            <xsl:apply-templates
                                                select="current-group()[position() = 4]"
                                                mode="fourth"/>
                                            <xsl:apply-templates
                                                select="current-group()[position() = 5]"
                                                mode="fifth"/>
                                        </ul>
                                    </div>
                                    <!-- End Mask -->
                                </div>
                                <!-- End Slider Container -->
                            </div>
                        </xsl:if>
                    </xsl:for-each-group>
                </div>
                <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
            </html>
        </xsl:result-document>

        <xsl:result-document method="html" href="GenrePHP/index/search.php">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="en">
                <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                <title>
                    <xsl:text>Search</xsl:text>
                </title>
                <xsl:processing-instruction name="php">
                        include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                <div id="inner">
                    <xsl:processing-instruction name="php">
                            include '../../search.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                </div>
                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
            </html>
        </xsl:result-document>
        
        <xsl:result-document method="html" href="GenrePHP/index/new.php">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="en">
                <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                <title>New Items</title>
                <xsl:processing-instruction name="php">
                        include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                <div id="inner">
                    <xsl:variable name="sortedMedia" select="*"/>
                    <xsl:for-each select="$sortedMedia">
                        <xsl:sort select="@dateCreated" order="descending"/>
                        <xsl:if test="position() &lt; 100">
                            <xsl:apply-templates select="." mode="movie"/>
                        </xsl:if>
                    </xsl:for-each>
                </div>
                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
            </html>
        </xsl:result-document> 
        
        <xsl:result-document method="html" href="GenrePHP/index/genreMap.php">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="en">
                <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                <title>Genre Map</title>
                <xsl:processing-instruction name="php">
                        include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                <div id="inner">
                    <ul class="map">
                        <xsl:for-each-group select="*" group-by="genreWrap/genre">
                            <xsl:sort select="current-grouping-key()"/>
                            <xsl:variable name="genre" select="current-grouping-key()"/>
                            <li>
                                <a href="http://library.emerson.edu/emflix/genrephp/index/search.php?searchTerm={current-grouping-key()}"><xsl:value-of select="current-grouping-key()"/></a>
                                <xsl:for-each select="current-grouping-key()">
                                    <ul>
                                        <xsl:for-each-group
                                            select="current-group()/genreWrap[genre = $genre]"
                                            group-by="subGenre">
                                            <xsl:sort select="current-grouping-key()"/>
                                            <xsl:variable name="subGenre"
                                                select="current-grouping-key()"/>
                                            <li>
                                                <a href="http://library.emerson.edu/emflix/genrephp/index/search.php?searchTerm={current-grouping-key()}"><xsl:value-of select="current-grouping-key()"/></a>
                                                <xsl:for-each select="current-grouping-key()">
                                                    <ul>
                                                        <xsl:for-each-group
                                                            select="current-group()/subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenre]]"
                                                            group-by=".">
                                                            <xsl:sort select="."/>
                                                            <li>
                                                                <a href="http://library.emerson.edu/emflix/genrephp/index/search.php?searchTerm={current-grouping-key()}"><xsl:value-of select="."/></a>
                                                            </li>
                                                        </xsl:for-each-group>
                                                    </ul>
                                                </xsl:for-each>
                                            </li>
                                        </xsl:for-each-group>
                                    </ul>
                                </xsl:for-each>
                            </li>
                        </xsl:for-each-group>
                    </ul>
                </div>
                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
            </html>
        </xsl:result-document> 

        <xsl:result-document method="html" href="GenrePHP/index/feedback.php">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="en">
                <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                <title>
                    <xsl:text>Emflix Feedback</xsl:text>
                </title>
                <xsl:processing-instruction name="php">
                        include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                <div id="inner">
                    <xsl:processing-instruction name="php">
                            include '../../error_report.html';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                </div>
                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
            </html>
        </xsl:result-document>

        <xsl:result-document method="html" href="GenrePHP/index/faq.php">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="en">
                <xsl:text disable-output-escaping="yes">&lt;head&gt;</xsl:text>
                <title>
                    <xsl:text>Emflix Faq</xsl:text>
                </title>
                <xsl:processing-instruction name="php">
                        include '../../nav.php';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                <div id="inner">
                    <xsl:processing-instruction name="php">
                            include '../../faq.html';<xsl:text>?</xsl:text>
                        </xsl:processing-instruction>
                </div>
                <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
                <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
            </html>
        </xsl:result-document>


    </xsl:template>

    <xsl:template match="media" mode="first">
        <li id="first" class="firstanimation">
            <!-- ID for tooltip and class for animation -->
            <a href="{callNumber/@href}" target="_blank">
                <img src="../../{coverArt/@href}"
                />
            </a>
        </li>
    </xsl:template>

    <xsl:template match="media" mode="second">
        <li id="second" class="secondanimation">
            <a href="{callNumber/@href}" target="_blank">
                <img src="../../{coverArt/@href}"
                />
            </a>
        </li>
    </xsl:template>

    <xsl:template match="media" mode="third">
        <li id="third" class="thirdanimation">
            <a href="{callNumber/@href}" target="_blank">
                <img src="../../{coverArt/@href}"
                />
            </a>
        </li>
    </xsl:template>

    <xsl:template match="media" mode="fourth">
        <li id="fourth" class="fourthanimation">
            <a href="{callNumber/@href}" target="_blank">
                <img src="../../{coverArt/@href}"
                />
            </a>
        </li>
    </xsl:template>

    <xsl:template match="media" mode="fifth">
        <li id="fifth" class="fifthanimation">
            <a href="{callNumber/@href}" target="_blank">
                <img src="../../{coverArt/@href}"
                />
            </a>
        </li>
    </xsl:template>




    <xsl:template match="*" mode="movie">
        <xsl:variable name="title">
            <!-- select="concat(title[not(@type) or ../self::movie[count(title) = 1]],' (',title[not(@type) or ../self::movie[count(title) = 1]]/@differentiator),')'"/> -->
            <xsl:value-of select="title[not(@type) or ../self::*[count(title) = 1]]"/>
            <xsl:if test="title[not(@type) or ../self::*[count(title) = 1]]/@differentiator">
                <xsl:value-of
                    select="concat(' (',title[not(@type) or ../self::*[count(title) = 1]]/@differentiator,')')"
                />
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="titleForeign">
            <xsl:value-of select="title[@type and ../self::*[count(title) > 1]]"/>
        </xsl:variable>
        <xsl:variable name="director" select="director"/>
        <xsl:variable name="writer" select="writer"/>

        <div class="box">
            <a href="{callNumber/@href}" target="_blank">

                <img src="../../{coverArt/@href}"
                    alt="Movie poster for {$title}"/>

                <!--    <img src="../../{coverArt/@href}" alt="Movie poster for {$title}"/>-->
            </a>
            <div class="tooltips">

                <div class="toolBody">
                    <div class="toolHeader">
                        <h3>
                            <xsl:value-of select="$title"/>
                        </h3>
                        <xsl:if test="title[@type='foreign']">
                            <h3 class="foreign">
                                <xsl:value-of select="$titleForeign"/>
                            </h3>
                        </xsl:if>
                        <xsl:if test="not(review)">
                            <form action="../../genrephp/index/feedback.php#review_form"
                                method="post">
                                <button type="submit" name="review_title" value="{$title}">Review
                                    Me!</button>
                            </form>
                        </xsl:if>
                        <form action="../../genrephp/index/feedback.php" method="post">
                            <button type="submit" name="report_error" value="{$title}">Report an
                                Error!</button>
                        </form>
                    </div>


                    <table>
                        <xsl:if test="director">
                            <tr>
                                <td class="role">Director:</td>
                                <td>
                                    <xsl:apply-templates select="director"/>

                                    <!--                       <xsl:for-each select="director">
                                <xsl:choose>
                                    <xsl:when test="position() = last()">
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(.,', ')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each> -->
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="writer">
                            <tr>
                                <td class="role">Writer:</td>
                                <td>
                                    <xsl:apply-templates select="writer"/>

                                    <!--     <xsl:for-each select="writer">
                                <xsl:choose>
                                    <xsl:when test="position() = last()">
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(.,', ')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each> -->
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="actor">
                            <tr>
                                <td class="role">Actor:</td>
                                <td>
                                    <xsl:apply-templates select="actor"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="creator">
                            <tr>
                                <td class="role">Creator:</td>
                                <td>
                                    <xsl:apply-templates select="creator"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="screenplay">
                            <tr>
                                <td class="role">Screenplay:</td>
                                <td>
                                    <xsl:apply-templates select="screenplay"/>

                                    <!--      <xsl:for-each select="screenplay">
                              <xsl:choose>
                                    <xsl:when test="position() = last()">
                                        <a href="{@href}"><xsl:value-of select="."/></a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <a href="{@href}"><xsl:value-of select="."/></a><text>, </text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each> -->
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="summary">
                            <tr>
                                <td class="role">Summary:</td>
                                <td>
                                    <xsl:value-of select="summary"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="review">
                            <tr>
                                <td class="role">Review:</td>
                                <td>
                                    <xsl:value-of select="review"/>
                                </td>
                            </tr>
                        </xsl:if>
                    </table>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template
        match="director[position() = last()] | writer[position() = last()] | creator[position() = last()] | actor[position() = last()]">
        <a href="../../GenrePHP/index/search.php?searchTerm={.}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>

    <xsl:template
        match="director[position() != last()] | writer[position() != last()]| creator[position() != last()] | actor[position() != last()]">
        <a href="../../GenrePHP/index/search.php?searchTerm={.}">
            <xsl:value-of select="concat(.,', ')"/>
        </a>
    </xsl:template>

    <xsl:template match="screenplay[position() = last()]">
        <a href="{./@href}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>

    <xsl:template match="screenplay[position() != last()]">
        <a href="{./@href}">
            <xsl:value-of select="concat(.,', ')"/>
        </a>
    </xsl:template>


    <!--
    <xsl:template match="/*" mode="header">
        <nav>
            <ul id="nav">
                <li>
                    <img class="logo" src="../../EmersonLogos/logo.emerson.gif"/>
                </li>
                <li class="top">
                    <a href="../index/index.html" class="top_link">
                        <span>Home</span>
                    </a>
                </li>
                <li class="top">
                    <a class="top_link">
                        <span class="down">Movie Genres</span>
                    </a>
                    <ul class="sub">
                        <xsl:for-each-group select="movie" group-by="genreWrap/genre">
                            <xsl:sort select="current-grouping-key()"/>
                            <xsl:variable name="genre" select="current-grouping-key()"/>
                            <li>
                                <a
                                    href="../{lower-case(translate($genre,' ',''))}/{lower-case(translate($genre,' ',''))}.html"
                                    class="fly">
                                    <xsl:value-of select="$genre"/>
                                </a>
                                <xsl:if test="current-group()/genreWrap[genre = $genre]/subGenre">
                                    <ul>
                                        <xsl:for-each-group
                                            select="current-group()/genreWrap[genre = $genre]"
                                            group-by="subGenre">
                                            <xsl:sort select="current-grouping-key()"/>
                                            <xsl:variable name="subGenre"
                                                select="current-grouping-key()"/>
                                            <li>
                                                <xsl:choose>
                                                  <xsl:when
                                                  test="current-group()/subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenre]]">
                                                  <a
                                                  href="../{lower-case(translate($genre,' ',''))}/{lower-case(translate($subGenre,' ',''))}.html"
                                                  class="fly">
                                                  <xsl:value-of select="$subGenre"/>
                                                  </a>
                                                  <ul>
                                                  <xsl:for-each-group
                                                  select="current-group()[subGenre = $subGenre]"
                                                  group-by="subSubGenre[preceding-sibling::*[1][self::subGenre = $subGenre]]">
                                                  <xsl:sort select="current-grouping-key()"/>
                                                  <xsl:variable name="subSubGenre"
                                                  select="current-grouping-key()"/>
                                                  <li>
                                                  <a
                                                  href="../{lower-case(translate($genre,' ',''))}/{lower-case(translate($subSubGenre,' ',''))}.html">
                                                  <xsl:value-of select="$subSubGenre"/>
                                                  </a>
                                                  </li>
                                                  </xsl:for-each-group>
                                                  </ul>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <a
                                                  href="../{lower-case(translate($genre,' ',''))}/{lower-case(translate($subGenre,' ',''))}.html">
                                                  <xsl:value-of select="$subGenre"/>
                                                  </a>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </li>
                                        </xsl:for-each-group>
                                    </ul>
                                </xsl:if>
                            </li>
                        </xsl:for-each-group>
                    </ul>
                </li>
                <li class="top">
                    <a href="../../tableMedia.html" class="top_link">
                        <span>Table View</span>
                    </a>
                </li>
            </ul>
        </nav>
    </xsl:template>
    -->
</xsl:stylesheet>
