<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="tei xs" version="3.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <!-- lead paragraph -->
    <xsl:template match="tei:p[@rend = 'Lead']/@rend">
        <xsl:attribute name="rend">lead</xsl:attribute>
    </xsl:template>

    <!-- superscript to sup -->
    <xsl:template match="tei:hi[@rend = 'superscript']/@rend">
        <xsl:attribute name="rend">sup</xsl:attribute>
    </xsl:template>

    <!-- image [todo: string auseinandernehmen] -->
    <xsl:template match="tei:p[@rend = 'Bild einfuegen']">
        <figure xmlns="http://www.tei-c.org/ns/1.0">
            <graphic>
                <xsl:analyze-string select="." regex="\[(\w+)='?([^\]]+)'?\]" flags="m">
                    <xsl:matching-substring>
                        <xsl:choose>
                            <xsl:when test="regex-group(1) = ('width', 'height', 'rend')">
                                <xsl:attribute name="{regex-group(1)}">
                                    <xsl:value-of select="regex-group(2)"/>
                                </xsl:attribute>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:if test="normalize-space(.) != ''">
                            <xsl:attribute name="url">
                                <xsl:value-of select="replace(normalize-space(.), '^(.*)\.[^\.]+$', '$1')"/>
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </graphic>
            <xsl:analyze-string select="." regex="\[([^=]+)='?([^'\]]+)'?\]" flags="m">
                <xsl:matching-substring>
                    <xsl:if test="regex-group(1) = 'figDesc'">
                        <figDesc>
                            <xsl:value-of select="regex-group(2)"/>
                        </figDesc>
                    </xsl:if>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </figure>
    </xsl:template>

    <!-- orgName -->
    <xsl:template match="tei:hi[@rend = 'Organisation']">
        <orgName xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="node()"/>
        </orgName>
    </xsl:template>

    <!--persName -->
    <xsl:template match="tei:hi[@rend = 'Person']">
        <persName xmlns="http://www.tei-c.org/ns/1.0" key="{following-sibling::*[@rend='annotation_reference'][1]/tei:note[1]/descendant::text()}">
            <xsl:apply-templates select="node()"/>
        </persName>
    </xsl:template>

    <!-- placeName -->
    <xsl:template match="tei:hi[@rend = 'PlaceName']">
        <placeName xmlns="http://www.tei-c.org/ns/1.0" key="{following-sibling::*[@rend='annotation_reference'][1]/tei:note[1]/descendant::text()}">
            <xsl:apply-templates select="node()"/>
        </placeName>
    </xsl:template>
    
    <!-- heads with comment -->
    <xsl:template match="tei:head[tei:hi/@rend = 'annotation_reference']">
        <head xmlns="http://www.tei-c.org/ns/1.0">
            <placeName key="{descendant::*[@rend='annotation_reference'][1]/tei:note[1]/descendant::text()}">
            <xsl:apply-templates select="node()"/>
        </placeName>
        </head>
    </xsl:template>
    <xsl:template match="tei:persName[@key = '']"/>
    <xsl:template match="tei:placeName[@key = '']"/>

    <!-- Abb Verweis -->
    <xsl:template match="tei:hi[@rend = 'Abb_verweis']">
        <ref xmlns="http://www.tei-c.org/ns/1.0" type="img">
            <xsl:apply-templates select="node()"/>
        </ref>
    </xsl:template>

    <!-- Endnotes -->
    <xsl:template match="tei:hi[@rend = 'endnote_reference']">
        <ref xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="node()"/>
        </ref>
    </xsl:template>

    <xsl:template match="@xmlns"/>
   
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    

</xsl:stylesheet>