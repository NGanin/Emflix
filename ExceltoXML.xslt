<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com" version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:function name="functx:substring-before-if-ends-with" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence
            select="
                if (ends-with($arg,$delim))
                then substring-before($arg,$delim)
                else $arg
                "
        />
    </xsl:function>

    <xsl:function name="functx:titleCase" as="xs:string">
        <xsl:param name="s" as="xs:string"/>
        <xsl:choose>
            <xsl:when
                test="lower-case($s)=('a','aboard','about','above','absent','across','after','against','alongside','amid','amidst','among','amongst','an','and','around','as','aslant','astride','at','athwart','atop','barring','before','behind','below','beneath','beside','besides','between','beyond','but','by','despite','down','during','except','failing','following','for','from','in','inside','into','like','mid','minus','near','next','nor','notwithstanding','of','off','on','onto','opposite','or','out','outside','over','past','per','plus','regarding','round','save','since','so','than','the','through','throughout','till','times','to','toward','towards','under','underneath','unlike','until','up','upon','via','vs.','when','with','within','without','worth','yet')">
                <xsl:value-of select="lower-case($s)"/>
            </xsl:when>
            <xsl:when test="$s=upper-case($s)">
                <xsl:value-of select="$s"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of
                    select="concat(upper-case(substring($s, 1, 1)), lower-case(substring($s, 2)))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="functx:right-trim" as="xs:string" xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select="
            replace($arg,'\s+$','')
            "/>
    </xsl:function>

    <xsl:function name="functx:capitalize-first" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select="concat(upper-case(substring($arg,1,1)),substring($arg,2))"/>
    </xsl:function>

    <!--
    <xsl:function name="functx:personSep">
        <xsl:param name="string"/>
        <xsl:param name="delim" as="xs:string*"/>
        <xsl:choose>
            <xsl:when test="not(contains($string,$delim))">
                <writer>
                    <xsl:value-of select="$string"/>
                </writer>
            </xsl:when>
            <xsl:when test="contains($string,$delim)">
                <writer>
                    <xsl:value-of select="substring-before($string, $delim)"/>
                </writer>
                <xsl:sequence select="functx:personSep(substring-after($string, $delim), $delim)"/>
            </xsl:when>
            <xsl:otherwise>
                <writer>
                    <xsl:text>fwap</xsl:text>
                </writer>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    -->

    <xsl:function name="functx:extract" as="element()*">
        <xsl:param name="input" as="xs:string"/>
        <xsl:param name="markers" as="xs:string*"/>
        <xsl:param name="element-name" as="xs:string"/>
        <xsl:analyze-string select="$input" regex="({string-join($markers, '|')})([^;]+)(\s;|$)">
            <!-- ({string-join($markers, '|')})([^.;]+)(;|\.|$) -->
            <xsl:matching-substring>
                <xsl:analyze-string select="regex-group(2)"
                    regex="([^,]+?)(((\sand|,|\s&amp;)\s)|$)">
                    <!-- (\w+(\s*\w*))(\s*(,|and|$)) -->
                    <xsl:matching-substring>
                        <xsl:element name="{$element-name}">
                            <xsl:if test="matches(regex-group(1),'^\w+\s\w+$')">
                                <xsl:attribute name="sort">
                                    <xsl:value-of
                                        select="string-length(substring-before(regex-group(1),' ')) + 2"
                                    />
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:value-of
                                select="functx:substring-before-if-ends-with(normalize-space(regex-group(1)),'.')"
                            />
                        </xsl:element>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:matching-substring>
            <xsl:fallback>
                <xsl:element name="{$element-name}"/>
            </xsl:fallback>
        </xsl:analyze-string>
    </xsl:function>

    <xsl:function name="functx:substring-after-last-match" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="regex" as="xs:string"/>

        <xsl:sequence select="
            replace($arg,concat('^.*',$regex),'')
            "/>

    </xsl:function>

    <xsl:variable name="date" select="substring(string(current-date()), 1, 10)"/>

    <!-- [position() > 1 and position() &lt;= 5] -->

    <xsl:template match="/">
        <mediaList>
            <xsl:apply-templates select="root/row"/>
        </mediaList>
    </xsl:template>

    <xsl:template match="row[not(contains(Heading1,'PN1992.77'))]">
        <media id="{Heading16}" dateCreated="{$date}" lastModified="{$date}">
            <title>
                <xsl:apply-templates select="Heading3" mode="title"/>
            </title>
            <xsl:apply-templates select="Heading2" mode="director"/>
            <xsl:apply-templates select="Heading14" mode="actor"/>
            <genreWrap>
                <genre/>
                <subGenre/>
            </genreWrap>
            <genreWrap>
                <genre/>
                <subGenre/>
            </genreWrap>
            <summary>
                <xsl:value-of select="Heading15"/>
            </summary>
            <LCSpecialTopics>
                <xsl:apply-templates select="Heading1" mode="specialTopics"/>
            </LCSpecialTopics>
            <xsl:apply-templates select="Heading2" mode="writer"/>
            <language>
                <xsl:apply-templates select="Heading11" mode="language"/>
            </language>
            <xsl:apply-templates select="Heading13"/>
            <callNumber
                href="http://endeavor.flo.org/vwebv/holdingsInfo?bibId={Heading16}">
                <xsl:value-of select="substring(Heading1, 1, 14)"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(Heading1, 15)"/>
            </callNumber>
            <coverArt href="Pics/"/>
    <!--        <otherStuff>
                <xsl:value-of select="Heading2"/>
                <moreStuff>
                    <xsl:value-of select="Heading13"/>
                    <xsl:value-of select="Heading14"/> 
                </moreStuff>
            </otherStuff> -->
        </media>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="row[contains(Heading1,'PN1992.77')]">
        <media id="{Heading16}" dateCreated="{$date}" lastModified="{$date}">
            <title differentiator="">
                <xsl:apply-templates select="Heading3" mode="title"/>
            </title>
            <xsl:apply-templates select="Heading2 | Heading13" mode="creator"/>
            <xsl:apply-templates select="Heading14" mode="actor"/>
            <genreWrap>
                <genre>Television</genre>
                <subGenre/>
                <subSubGenre/>
            </genreWrap>
            <summary>
                <xsl:value-of select="Heading15"/>
            </summary>
            <LCSpecialTopics>Individual programs</LCSpecialTopics>
            <language>
                <xsl:apply-templates select="Heading11" mode="language"/>
            </language>
            <yearRange>
                <yearBegin/>
                <yearEnd/>
            </yearRange>
            <callNumber
                href="http://endeavor.flo.org/vwebv/holdingsInfo?bibId={Heading16}">
                <xsl:value-of select="substring(Heading1, 1, 15)"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(Heading1, 16)"/>
            </callNumber>
            <coverArt href="Pics/"/>
            <!--        <otherStuff>
                <xsl:value-of select="Heading2"/>
                <moreStuff>
                    <xsl:value-of select="Heading13"/>
                    <xsl:value-of select="Heading14"/> 
                </moreStuff>
            </otherStuff> -->
        </media>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="Heading1" mode="specialTopics">
        <xsl:choose>
            <xsl:when test="contains(., '1992.8')">TV Minieries</xsl:when>
            <xsl:when test="contains(., '.75 ')">Silent films</xsl:when>
            <xsl:when test="contains(., '.A1 ')">Miscellaneous collections</xsl:when>
            <xsl:when test="contains(., '.A26 ')">Acting. Auditions</xsl:when>
            <xsl:when test="contains(., '.A3 ')">Adventure films</xsl:when>
            <xsl:when test="contains(., '.A43 ')">Africa</xsl:when>
            <xsl:when test="contains(., '.A45 ')">Alcoholism</xsl:when>
            <xsl:when test="contains(., '.A5 ')">Animals</xsl:when>
            <xsl:when test="contains(., '.A54 ')">Animation</xsl:when>
            <xsl:when test="contains(., '.A72 ')">Armed Forces</xsl:when>
            <xsl:when test="contains(., '.A73 ')">Art and the arts</xsl:when>
            <xsl:when test="contains(., '.A77 ')">Asian Americans</xsl:when>
            <xsl:when test="contains(., '.B53 ')">Bible films</xsl:when>
            <xsl:when test="contains(., '.B55 ')">Biographical films</xsl:when>
            <xsl:when test="contains(., '.B76 ')">Brooklyn</xsl:when>
            <xsl:when test="contains(., '.B87 ')">Business</xsl:when>
            <xsl:when test="contains(., '.C39 ')">Child sexual abuse</xsl:when>
            <xsl:when test="contains(., '.C45 ')">Children and adolescents</xsl:when>
            <xsl:when test="contains(., '.C5113 ')">Christmas</xsl:when>
            <xsl:when test="contains(., '.C512 ')">Circus</xsl:when>
            <xsl:when test="contains(., '.C513 ')">City and town life</xsl:when>
            <xsl:when test="contains(., '.C543 ')">College life films</xsl:when>
            <xsl:when test="contains(., '.C55 ')">Comedy</xsl:when>
            <xsl:when test="contains(., '.C58 ')">Country Life</xsl:when>
            <xsl:when test="contains(., '.C85 ')">Culture conflict</xsl:when>
            <xsl:when test="contains(., '.D37 ')">Death</xsl:when>
            <xsl:when test="contains(., '.D4 ')">Detective and mystery films</xsl:when>
            <xsl:when test="contains(., '.D55 ')">Disasters</xsl:when>
            <xsl:when test="contains(., '.D6 ')">Documentary films</xsl:when>
            <xsl:when test="contains(., '.D68 ')">Drifters</xsl:when>
            <xsl:when test="contains(., '.D78 ')">Drugs</xsl:when>
            <xsl:when test="contains(., '.E44 ')">Emigration and immigration</xsl:when>
            <xsl:when test="contains(., '.E79 ')">Epic films</xsl:when>
            <xsl:when test="contains(., '.E96 ')">Experimental films</xsl:when>
            <xsl:when test="contains(., '.F35 ')">Family</xsl:when>
            <xsl:when test="contains(., '.F36 ')">Fantastic films</xsl:when>
            <xsl:when test="contains(., '.F54 ')">Films Noirs</xsl:when>
            <xsl:when test="contains(., '.F56 ')">Flashbacks</xsl:when>
            <xsl:when test="contains(., '.F67 ')">Foreign films</xsl:when>
            <xsl:when test="contains(., '.G26 ')">Gambling</xsl:when>
            <xsl:when test="contains(., '.G3 ')">Gangster films</xsl:when>
            <xsl:when test="contains(., '.G57 ')">Girls</xsl:when>
            <xsl:when test="contains(., '.H3 ')">Hand-to-hand fighting, Oriental. Martial arts
                films</xsl:when>
            <xsl:when test="contains(., '.H34 ')">Handicapped. People with disabilities</xsl:when>
            <xsl:when test="contains(., '.H5 ')">Historical films</xsl:when>
            <xsl:when test="contains(., '.H53 ')">Holocaust, Jewish (1939-1945)</xsl:when>
            <xsl:when test="contains(., '.H55 ')">Homosexuality</xsl:when>
            <xsl:when test="contains(., '.H6 ')">Horror films</xsl:when>
            <xsl:when test="contains(., '.I48 ')">Indians</xsl:when>
            <xsl:when test="contains(., '.I55 ')">Intercultural communication</xsl:when>
            <xsl:when test="contains(., '.I72 ')">Israel</xsl:when>
            <xsl:when test="contains(., '.J3 ')">James Bond films</xsl:when>
            <xsl:when test="contains(., '.J6 ')">Journalists</xsl:when>
            <xsl:when test="contains(., '.J8 ')">Justice. Law</xsl:when>
            <xsl:when test="contains(., '.J87 ')">Juvenile delinquency</xsl:when>
            <xsl:when test="contains(., '.L28 ')">Labor. Working class</xsl:when>
            <xsl:when test="contains(., '.L37 ')">Latin America. Latin Americans</xsl:when>
            <xsl:when test="contains(., '.L5 ')">Literature adaptations</xsl:when>
            <xsl:when test="contains(., '.L6 ')">Love</xsl:when>
            <xsl:when test="contains(., '.M27 ')">Man-woman relationships</xsl:when>
            <xsl:when test="contains(., '.M3 ')">Marriage. Weddings</xsl:when>
            <xsl:when test="contains(., '.M45 ')">Melodrama</xsl:when>
            <xsl:when test="contains(., '.M46 ')">Men</xsl:when>
            <xsl:when test="contains(., '.M463 ')">Mental illness</xsl:when>
            <xsl:when test="contains(., '.M6 ')">Monsters</xsl:when>
            <xsl:when test="contains(., '.M65 ')">Motion picture industry in motion
                pictures</xsl:when>
            <xsl:when test="contains(., '.M86 ')">Musical films. Rock musical films</xsl:when>
            <xsl:when test="contains(., '.N36 ')">National socialism. Nazis</xsl:when>
            <xsl:when test="contains(., '.N4 ')">Negroes. Blacks. African Americans</xsl:when>
            <xsl:when test="contains(., '.O8 ')">Our Gang films</xsl:when>
            <xsl:when test="contains(., '.P44 ')">Physicians. Medical personnel</xsl:when>
            <xsl:when test="contains(., '.P57 ')">Police films</xsl:when>
            <xsl:when test="contains(., '.P6 ')">Politics</xsl:when>
            <xsl:when test="contains(., '.P67 ')">Prehistoric animals</xsl:when>
            <xsl:when test="contains(., '.P68 ')">Prison films</xsl:when>
            <xsl:when test="contains(., '.P7 ')">Production and direction</xsl:when>
            <xsl:when test="contains(., '.R4 ')">Religion</xsl:when>
            <xsl:when test="contains(., '.R63 ')">Road films</xsl:when>
            <xsl:when test="contains(., '.S24 ')">Samurai films</xsl:when>
            <xsl:when test="contains(., '.S26 ')">Science fiction films</xsl:when>
            <xsl:when test="contains(., '.S284 ')">Sensationalism. Exploitation films</xsl:when>
            <xsl:when test="contains(., '.S297 ')">Serial murderers</xsl:when>
            <xsl:when test="contains(., '.S45 ')">Sex. Erotic films. Pornographic films</xsl:when>
            <xsl:when test="contains(., '.S55 ')">Sisters</xsl:when>
            <xsl:when test="contains(., '.S557 ')">Slavery</xsl:when>
            <xsl:when test="contains(., '.S6 ')">Social aspects</xsl:when>
            <xsl:when test="contains(., '.S62 ')">Social problems</xsl:when>
            <xsl:when test="contains(., '.S655 ')">South Africa</xsl:when>
            <xsl:when test="contains(., '.S67 ')">Sports</xsl:when>
            <xsl:when test="contains(., '.S68 ')">Spy films. Espionage</xsl:when>
            <xsl:when test="contains(., '.S74 ')">Suburbs. Suburban life</xsl:when>
            <xsl:when test="contains(., '.S76 ')">Superhero films</xsl:when>
            <xsl:when test="contains(., '.S8 ')">Supernatural. Angels. Ghosts</xsl:when>
            <xsl:when test="contains(., '.S85')">Surrealism</xsl:when>
            <xsl:when test="contains(., '.S87 ')">Suspense. Thrillers</xsl:when>
            <xsl:when test="contains(., '.T4 ')">Teachers</xsl:when>
            <xsl:when test="contains(., '.T46 ')">Terrorism</xsl:when>
            <xsl:when test="contains(., '.T5 ')">Three Stooges films</xsl:when>
            <xsl:when test="contains(., '.T69 ')">Transvestism</xsl:when>
            <xsl:when test="contains(., '.T75 ')">Trials</xsl:when>
            <xsl:when test="contains(., '.V3 ')">Vampire films</xsl:when>
            <xsl:when test="contains(., '.V44 ')">Veterans</xsl:when>
            <xsl:when test="contains(., '.W3 ')">War</xsl:when>
            <xsl:when test="contains(., '.W4 ')">Western films</xsl:when>
            <xsl:when test="contains(., '.W6 ')">Women</xsl:when>
            <xsl:when test="contains(., '.Y6 ')">Youth</xsl:when>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="Heading11" mode="language">
        <xsl:choose>
            <xsl:when test=". = 'ara'">Arabic</xsl:when>
            <xsl:when test=". = 'arc'">Aramaic</xsl:when>
            <xsl:when test=". = 'arm'">Armenian</xsl:when>
            <xsl:when test=". = 'art'">Artificial (Other)</xsl:when>
            <xsl:when test=". = 'bam'">Bambara</xsl:when>
            <xsl:when test=". = 'ben'">Bengali</xsl:when>
            <xsl:when test=". = 'bnt'">Bantu</xsl:when>
            <xsl:when test=". = 'bos'">Bosnian</xsl:when>
            <xsl:when test=". = 'chi'">Chinese</xsl:when>
            <xsl:when test=". = 'crp'">Creole</xsl:when>
            <xsl:when test=". = 'cze'">Czech</xsl:when>
            <xsl:when test=". = 'dan'">Danish</xsl:when>
            <xsl:when test=". = 'dut'">Dutch</xsl:when>
            <xsl:when test=". = 'dyu'">Dyula</xsl:when>
            <xsl:when test=". = 'eng'">English</xsl:when>
            <xsl:when test=". = 'fre'">French</xsl:when>
            <xsl:when test=". = 'ger'">German</xsl:when>
            <xsl:when test=". = 'gre'">Greek</xsl:when>
            <xsl:when test=". = 'heb'">Hebrew</xsl:when>
            <xsl:when test=". = 'hin'">Hindi</xsl:when>
            <xsl:when test=". = 'hun'">Hungarian</xsl:when>
            <xsl:when test=". = 'ind'">Indonesian</xsl:when>
            <xsl:when test=". = 'ita'">Italian</xsl:when>
            <xsl:when test=". = 'jpn'">Japanese</xsl:when>
            <xsl:when test=". = 'kor'">Korean</xsl:when>
            <xsl:when test=". = 'mos'">Mossi</xsl:when>
            <xsl:when test=". = 'mul'">MultipleLang</xsl:when>
            <xsl:when test=". = 'myn'">Mayan</xsl:when>
            <xsl:when test=". = 'nor'">Norwegian</xsl:when>
            <xsl:when test=". = 'per'">Persian</xsl:when>
            <xsl:when test=". = 'pol'">Polish</xsl:when>
            <xsl:when test=". = 'por'">Portuguese</xsl:when>
            <xsl:when test=". = 'pus'">Pushto</xsl:when>
            <xsl:when test=". = 'rum'">Romanian</xsl:when>
            <xsl:when test=". = 'rus'">Russian</xsl:when>
            <xsl:when test=". = 'spa'">Spanish</xsl:when>
            <xsl:when test=". = 'swe'">Swedish</xsl:when>
            <xsl:when test=". = 'tha'">Thai</xsl:when>
            <xsl:when test=". = 'tib'">Tibetan</xsl:when>
            <xsl:when test=". = 'und'">Undetermined</xsl:when>
            <xsl:when test=". = 'urd'">Urdu</xsl:when>
            <xsl:when test=". = 'wol'">Wolof</xsl:when>
            <xsl:when test=". = 'zul'">Zulu</xsl:when>
            <xsl:when test=". = 'zxx'">No linguistic content</xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="Heading3" mode="title">
        <xsl:variable name="title"
            select="functx:substring-before-if-ends-with(functx:substring-before-if-ends-with((normalize-space(.)),' /'), '.')"/>
        <xsl:sequence
            select="functx:capitalize-first(string-join(for $x in tokenize($title,'\s') return functx:titleCase($x),' '))"
        />
    </xsl:template>

    <!--
    <xsl:template match="Heading2" mode="writer">
        <xsl:variable name="cell3Data" select="normalize-space(.)"/>
        <writer>
            <xsl:variable name="writerFind" as="xs:string*"
                select="('screenplay by ','written by ','written and directed by ','written for the screen and directed by ','screen play and dialogue by ','screenplay writer, ','screenplay, ','written, produced, and directed by ','screen play by ','written and produced by ', 'written &amp; directed by ','screenplay and dialogue, ','writer/director, ', 'writer, ')"/>

            <xsl:for-each select="1 to count($writerFind)">
                <xsl:variable name="x" select="."/>
                <xsl:variable name="writer" select="substring-after($cell3Data, $writerFind[$x])"/>
                <xsl:value-of select="functx:right-trim(replace($writer, '[;\.].*$', ''))"/>
            </xsl:for-each>
        </writer>
    </xsl:template>
-->
    <!--
    <xsl:template match="Heading2" mode="writer">
        <xsl:variable name="cell3Data" select="normalize-space(.)"/>

        <xsl:variable name="writerFind" as="xs:string*"
            select="('writer and director, ','screenplay by ','written by ','written and directed by ','written for the screen and directed by ','screen play and dialogue by ','screenplay writer, ','screenplay, ','written, produced, and directed by ','written, directed and produced by ','screen play by ','written and produced by ', 'written &amp; directed by ')"/>

        <xsl:for-each select="1 to count($writerFind)">
            <xsl:variable name="x" select="."/>
            <xsl:variable name="writer" select="substring-after($cell3Data, $writerFind[$x])"/>
            <xsl:if test="$writer != ''">
                <xsl:if test="contains($writer, ' and ')">
                    <xsl:sequence
                        select="functx:personSep(functx:right-trim(replace($writer, '[;\.].*$', '')),' and ')"
                    />
                </xsl:if>
                <xsl:if test="contains($writer, ', ')">
                    <xsl:sequence
                        select="functx:personSep(functx:right-trim(replace($writer, '[;\.].*$', '')),', ')"
                    />
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
-->

    <xsl:template match="Heading2" mode="writer">
        <!--   <xsl:analyze-string select="." regex="('screenplay by ','screen play by ','screenplay, '|written by |written and directed by |written for the screen and directed by |screen play and dialogue by |screenplay writer, |screenplay, |written, produced, and directed by |written, produced and directed by |written, directed and produced by |screen play by |written and produced by |written &amp; directed by |writer-director, |script, )([^.;]+)(;|\.|$)"> -->
        <xsl:sequence
            select="functx:extract(normalize-space(.),('written, produced, directed by ','screen play, ','writer and director, ','written for the screen by ','written for the screen, produced and directed by ','produced, written, and directed by ','written &amp; produced by ','written for the screen &amp; directed by ','written, directed and edited by ','script by ','screenplay and directed by ','written and edited by ','screen story by ','screen story &amp; dialogue by ',' written, edited &amp; directed by ','writers and directors, ','writer, ','written, produced &amp; directed by ','screenplay &amp; dialogues, ','writers, ','screenplay by ','written by ','written and directed by ','written for the screen and directed by ','screen play and dialogue by ','screenplay writer, ','screenplay, ','written, produced, and directed by ','written, produced and directed by ','written, directed and produced by ','screen play by ','written and produced by ','written &amp; directed by ','writer-director, ','script, ','screenplay, music, and direction by '),'writer')"
        />
    </xsl:template>

    <xsl:template match="Heading2" mode="director">
        <xsl:sequence
            select="functx:extract(normalize-space(.),('written, directed and edited by ','director/writer, ','directed &amp; produced by','directors, ','direction by ','directed by ','director, ','directed and written by ','directed and produced by ','directed, written and produced by ','direction, '),'director')"
        />
    </xsl:template>
    
    <xsl:template match="Heading2 | Heading13" mode="creator">
        <xsl:sequence
            select="functx:extract(normalize-space(.),('Created by ','created by ','creator '),'creator')"
        />
    </xsl:template>
    
    <xsl:template match="Heading14" mode="actor">
        <xsl:sequence
            select="functx:extract(normalize-space(.),(),'actor')"/>
    </xsl:template>

    <xsl:template match="Heading13">
        <xsl:variable name="cell14Data" select="normalize-space(.)"/>
        <xsl:variable name="yearFind" as="xs:string*"
            select="('motion picture in ','release of the ','released in ')"/>
        <year>
            <xsl:variable name="yearFound">
                <xsl:for-each select="1 to count($yearFind)">
                    <xsl:variable name="x" select="."/>
                    <xsl:value-of
                        select="substring(substring-after($cell14Data, $yearFind[$x]),1,4)"/>
                </xsl:for-each>
            </xsl:variable>

            <xsl:choose>
                <xsl:when test="matches($yearFound, '(19|20)\d{2}')">
                    <xsl:value-of select="$yearFound"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space(../../Heading8)"/>
                </xsl:otherwise>
            </xsl:choose>
        </year>
    </xsl:template>
    <!--
    <xsl:template match="Heading13">
        <xsl:variable name="cell14Data" select="normalize-space(.)"/>
        <year>
            <xsl:analyze-string select="$cell14Data" regex="(19|20)\d{{2}}">
                <xsl:matching-substring>
                    <xsl:value-of select="."/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </year>
    </xsl:template>
    -->

</xsl:stylesheet>
