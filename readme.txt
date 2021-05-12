All requested changes have been made EXCEPT: "Massive container listings should be ranges (per Rusty’s initial style sheet) (example: SR.45)."

This wasn't  part of the initial changes requested, and I ran out of time and didn't want to risk breaking something. It wasn't working correctly in Rusty's stylesheet, to fix consider changing line 20 from:
    <xsl:variable name="county_no" select="substring-after(ead/eadheader/eadid,'CR.')"/>

To something like this:
    <xsl:variable name="local_id" select="ead/archdesc/did/unitid[@type='local ID']/."/>
    <xsl:variable name="county_no" select="substring-after($local_id,'CR.')"/>

And in the 'series' template, the following would also need to be re examined (so that the containers aren't repeated), Lines 599-699:
                    <xsl:choose>
                        <xsl:when test="not(did/container)"/>
                        <xsl:otherwise>
                            <xsl:if test="not(did/container/@parent)">
                                <xsl:call-template name="cr_containers"/>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="not(descendant::c02)">
                    <xsl:call-template name="odd_ns"/>
                    </xsl:if>

It was only set up for county records. To extend this functionality to other containers, I believe the logic from template 'cr_containers' would need to be added and adapted to the template 'ns_containers' and/or 'sa_containers'. 