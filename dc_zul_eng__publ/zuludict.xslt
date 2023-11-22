<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">

    <xsl:output method="html"/>
    <xsl:variable name="var1" select="concat('#',//@xml:id)"/>
    <xsl:template match="/">
        
        <div>
           <div class="dvStats">
               <xsl:variable name="recNum"><xsl:value-of select="count(//tei:div[@type='results']/tei:entry)"/></xsl:variable>
              <xsl:value-of select="$recNum"/><xsl:text> </xsl:text> 
              <xsl:choose>
                 <xsl:when test="$recNum=0">records. Try to add .* to your query.</xsl:when>
                 <xsl:when test="$recNum=1">record</xsl:when>
                 <xsl:otherwise>records</xsl:otherwise>
              </xsl:choose>
           </div>
            
            <!-- ********************************************* -->
            <!-- ***  ENTRY ********************************** -->
            <!-- ********************************************* -->
            <xsl:for-each select="//tei:div[@type='results']/tei:entry">
               <xsl:sort select="./tei:form/tei:orth"/>
               <div class="dvRoundLemmaBox_ltr">
                  <xsl:value-of select="tei:form[@type='lemma']/tei:orth[@xml:lang='zu'] | tei:form[@type='multiWordUnit']/tei:orth[@xml:lang='zu'] | tei:form[@type='abbrev']/tei:orth[@xml:lang='zu']"/>
                  <xsl:if test="tei:gramGrp/tei:gram[@type='pos']">
                      <span class="spGramGrp">
                          <xsl:text> </xsl:text>
                          (<xsl:value-of select="tei:gramGrp/tei:gram[@type='pos']"/>)
                       </span>                                                                 
                  </xsl:if>
               </div>               
               
               <table class="tbEntry">
                 <!-- ********************************************* -->
                 <!-- ***  VARIANTS OF LEMMA  ********************* -->
                 <!-- ********************************************* -->
                  <xsl:for-each select="tei:form[@type='lemmaVariant']">
                    <tr>
                       <td class="tdHead">Var.</td>
                       <td>
                          <xsl:if test="tei:orth[@xml:lang='zu']">                                     
                             <xsl:value-of select="tei:orth[@xml:lang='zu']"/>                                         
                             <xsl:if test="tei:usg"><span class="spGramGrp"><xsl:text> </xsl:text>(<xsl:value-of select="tei:usg"/>)</span></xsl:if>
                                   
                          </xsl:if>

                          <xsl:if test="tei:bibl">
                             <span class="spBibl">
                                (<xsl:for-each select="tei:bibl"><xsl:if test="position()&gt;1">;<xsl:text> </xsl:text></xsl:if>
                                 <xsl:value-of select="."/>
                                 </xsl:for-each>)
                              </span>
                          </xsl:if>
                       </td>
                     </tr>
                  </xsl:for-each>

                  <!-- ********************************************* -->
                  <!-- ***  ETYMOLOGY ****************************** -->
                  <!-- ********************************************* -->
                  <xsl:if test="string-length(tei:etym)&gt;0">
                     <tr>
                        <td class="tdHead">Etym.</td>
                        <td>
                           <span class="spEtym">
                              <xsl:for-each select="tei:etym">
                                 <xsl:if test="tei:mentioned">
                                    <xsl:value-of select="tei:mentioned"/>
                                 </xsl:if>
                                 
                                 <xsl:if test="tei:lang">
                                     (<xsl:value-of select="tei:lang"/>)
                                 </xsl:if>
                              </xsl:for-each>
                           </span>
                        </td>                           
                     </tr>                     
                  </xsl:if>
                  <!-- ********************************************* -->
                  <!-- ***  INFLECTED FORMS (Pls, etc.) ************ -->
                  <!-- ********************************************* -->
                  <xsl:if test="string-length(tei:form[@type='inflected'])&gt;0">
                     <tr>
                        <td class="tdHead">Inflected</td>
                        <td>
                           <xsl:for-each select="tei:form[@type='inflected']">
                               <xsl:if test="string-length(tei:orth[@xml:lang='zu'])&gt;0">
                                  <xsl:if test="position()&gt;1">,<xsl:text> </xsl:text></xsl:if>
                                  <xsl:value-of select="tei:orth[@xml:lang='zu']"/>

                               <!-- ********************************************* -->
                               <!-- ***  ANA attributes   *********************** -->
                               <!-- ********************************************* -->
                               <xsl:if test="@ana">
                                  <span class="spGramGrp"><xsl:text> </xsl:text>                         
                                     <xsl:choose>
                                         <xsl:when test="@ana='#n_pl'">[plural]</xsl:when>
                                         <xsl:when test="@ana='#n_loc'">[locative]</xsl:when>
                                         <xsl:when test="@ana='#n_pl_loc'">[locative, plural]</xsl:when>
                                         
                                        <xsl:otherwise>[<xsl:value-of select="@ana"/>]</xsl:otherwise>
                                     </xsl:choose>
                                   </span>
                               </xsl:if>

                                   <!-- ********************************************* -->
                                   <!-- ***  USG of infl.  ************************** -->
                                   <!-- ********************************************* -->
                                   <xsl:if test="tei:usg"><xsl:text> </xsl:text>(<xsl:value-of select="tei:usg"/>)</xsl:if>
                               </xsl:if>
                           </xsl:for-each>
                        </td>
                     </tr>
                  </xsl:if>
                             
                   <!-- ********************************************* -->
                   <!-- ***  DERIVED FORMS (Pls, etc.) ************ -->
                   <!-- ********************************************* -->
                   <xsl:if test="string-length(tei:form[@type='derived'])&gt;0">
                       <tr>
                           <td class="tdHead">Derived</td>
                           <td>
                               <div class="dvDerivedContainer">
                               <xsl:for-each select="tei:form[@type='derived']">
                                   <xsl:if test="string-length(tei:orth[@xml:lang='zu'])&gt;0"><xsl:if test="position()&gt;1">,<xsl:text> </xsl:text></xsl:if>
                                       <xsl:value-of select="tei:orth[@xml:lang='zu']"/>
                                       
                                       <!-- ********************************************* -->
                                       <!-- ***  ANA attributes   *********************** -->
                                       <!-- ********************************************* -->
                                       <xsl:if test="@ana">
                                           <span class="spGramGrp"><xsl:text> </xsl:text>
                                               <xsl:choose>
                                                   <xsl:when test="@ana='#vb_ela'">[applicative]</xsl:when>
                                                   <xsl:when test="@ana='#vb_ela_pass'">[applicative, pass.]</xsl:when>
                                                   <xsl:when test="@ana='#vb_elaPerf'">[applicative, perf.]</xsl:when>
                                                   <xsl:when test="@ana='#vb_pass'">[passive]</xsl:when>
                                                   <xsl:when test="@ana='#vb_passive'">[passive]</xsl:when>
                                                   <xsl:when test="@ana='#vb_pass_ile'">[passive, perf.]</xsl:when>
                                                   <xsl:when test="@ana='#vb_pass_long'">[passive (long)]</xsl:when>
                                                   <xsl:when test="@ana='#vb_ile'">[perf.]</xsl:when>
                                                   <xsl:when test="@ana='#vb_neut'">[neuter]</xsl:when>
                                                   <xsl:when test="@ana='#vb_isa'">[causative]</xsl:when>
                                                   <xsl:when test="@ana='#vb_caus'">[causative]</xsl:when>
                                                   <xsl:when test="@ana='#vb_ana'">[reciprocal]</xsl:when>
                                                   <xsl:when test="@ana='#vb_eka'">[neuter]</xsl:when>
                                                   <xsl:when test="@ana='#adj_dim'">[dim.]</xsl:when>
                                                   <xsl:when test="@ana='#n_dim'">[dim.]</xsl:when>
                                                   
                                                   <xsl:otherwise></xsl:otherwise>
                                               </xsl:choose>
                                           </span>
                                       </xsl:if>
                                       
                                       <!-- ********************************************* -->
                                       <!-- ***  USG of infl.  ************************** -->
                                       <!-- ********************************************* -->
                                       <xsl:if test="tei:usg"><xsl:text> </xsl:text>(<xsl:value-of select="tei:usg"/>)</xsl:if>
                                   </xsl:if>
                               </xsl:for-each>
                               </div>
                           </td>
                       </tr>
                   </xsl:if>
                   
                   <!-- ********************************************* -->
                  <!-- ** SENSES *********************************** -->
                  <!-- ********************************************* -->
                  <xsl:for-each select="tei:sense">
                     <xsl:if test="./tei:def">
                       <tr>
                          <td class="tdSenseHead">Defs.</td>
                          <td class="tdSense">
                             <div class="dvDef">
                                 <xsl:for-each select="tei:def[@xml:lang='en'] | tei:def[@lang='en']">
                                   <xsl:if test="string-length(.)&gt;1">                                    
                                      <span class="spTransEn">
                                         <xsl:if test="position()&gt;1">,<xsl:text> </xsl:text></xsl:if>
                                         <xsl:value-of select="."/>
                                      </span>
                                   </xsl:if>
                                </xsl:for-each>   
                                
                                <div class="dvLangSep">
                                   <xsl:for-each select="tei:def[@xml:lang='fr'] | tei:def[@lang='fr']">
                                      <xsl:if test="string-length(.)&gt;1">                                    
                                         <span class="spTransFr">
                                            <xsl:if test="position()&gt;1">,<xsl:text> </xsl:text></xsl:if>
                                            <xsl:value-of select="."/>
                                         </span>
                                      </xsl:if>
                                   </xsl:for-each>   
                                </div>
                                                                
                              </div>     
                          </td>
                       </tr> 
                     </xsl:if>
                     
                     <tr>
                         <td class="tdSenseHead">Sense
                             <xsl:if test="count(parent::tei:entry/tei:sense)&gt;1"><xsl:text> </xsl:text>
                              <xsl:value-of select="position()"/>
                           </xsl:if>
                            <!-- ********************************************* -->
                            <!-- ** ARGUMENTS ******************************** -->
                            <!-- ********************************************* -->
                            <xsl:if test="tei:gramGrp/tei:gram[@type='arguments']">
                                <div class="dvDef">
                                    <xsl:value-of select="parent::tei:form[@type='lemma']/tei:orth[@xml:lang='zu'] | parent::tei:form[@type='multiWordUnit']/tei:orth[@xml:lang='zu'] | parent::tei:form[@type='abbrev']/tei:orth[@xml:lang='zu']"/>
                                    <span class="dvArguments"><xsl:value-of select="tei:gramGrp/tei:gram[@type='arguments']"/></span>
                                </div>   
                            </xsl:if>
                        </td>
                        <td class="tdSense">

                           <div class="dvDef">
                              <xsl:for-each select="tei:cit[@type='translation'][@xml:lang='en']">
                                 <xsl:if test="string-length(.)&gt;1">                                    
                                    <span class="spTransEn">
                                       <xsl:if test="position()&gt;1">,<xsl:text> </xsl:text></xsl:if>
                                       <xsl:value-of select="tei:quote"/>
                                        <xsl:if test="tei:usg"><xsl:text> </xsl:text>(<xsl:value-of select="tei:usg"/>)</xsl:if>
                                    </span>
                                 </xsl:if>
                              </xsl:for-each>
                              <!-- ********************************************* -->
                              <!-- ** USG ************************************** -->
                              <!-- ********************************************* -->
                              <xsl:if test="tei:usg[@xml:lang='en']">
                                  <span class="dvUsg"><xsl:text> </xsl:text>(<xsl:value-of select="tei:usg[@xml:lang='en']"/>)</span>   
                              </xsl:if>
                                                                                         
                           </div>
                           
                            <div class="dvMwuExamplesContainer">
                                <xsl:for-each select="./tei:entry[tei:form/@type='multiWordUnit']">
                                    <div class="dvMWUExamples">
                                    <xsl:value-of select="tei:form/tei:orth[@xml:lang='zu']"/>
                                    <span class="spTransEn"><xsl:text> </xsl:text><xsl:value-of select="tei:sense/tei:cit/tei:quote"/></span>
                                </div>
                                </xsl:for-each>
                            </div>
                            
                            <xsl:for-each select="tei:cit[@type='example']">
                              <div class="dvExamples">
                                 <xsl:if test="tei:quote[@xml:lang='zu']">
                                     <!-- <xsl:value-of select="tei:quote[@xml:lang='zu']"/> -->
                                     <xsl:apply-templates select="tei:quote[@xml:lang='zu']"/>
                                 </xsl:if>
                                 <xsl:for-each select="tei:cit[@type='translation'][@xml:lang='en']">                                    
                                    <span class="spTransEn"><xsl:text> </xsl:text><xsl:value-of select="tei:quote"/></span>                                                                        
                                 </xsl:for-each>
                              </div>
                           </xsl:for-each>
                           
                           <xsl:for-each select="tei:cit[@type='multiWordUnit'][@xml:lang='zu']">
                              <div class="dvMWUExamples">
                                 <table>
                                    <tr>
                                       <xsl:if test="tei:quote[@xml:lang='zu']">
                                         <td class="tdNoBorder">
                                            <xsl:value-of select="tei:quote[@xml:lang='zu']"/>
                                         </td>
                                      </xsl:if>
                                      <td class="tdNoBorder">
                                         <xsl:for-each select="tei:cit[@type='translation']">
                                            <div class="dvDef">
                                              <span class="spTrans">
                                                 <xsl:value-of select="tei:quote[@xml:lang='zu']"/>
                                                 <xsl:if test="tei:usg"><xsl:text> </xsl:text>
                                                   (<xsl:value-of select="tei:usg"/>)
                                                 </xsl:if>
                                              </span>
                                            </div>
                                         </xsl:for-each>
                                      </td>
                                   </tr>
                                </table>
                             </div>
                           </xsl:for-each>
                           
                           <xsl:for-each select="tei:entry[@type='example']">
                              <div class="dvMWUExamples">
                                 <table>
                                     <tr>
                                        <xsl:if test="tei:form/tei:orth[@xml:lang='zu']">
                                           <td class="tdNoBorder">
                                              <xsl:value-of select="tei:form/tei:orth[@xml:lang='zu']"/>
                                           </td>
                                        </xsl:if>

                                        <td class="tdNoBorder">
                                           <xsl:for-each select="tei:sense">
                                                <div class="dvDef">
                                                   <span class="spTrans">
                                                      <xsl:value-of select="tei:cit/tei:quote[@xml:lang='zu']"/>

                                                      <xsl:if test="tei:usg"> 
                                                         (<xsl:value-of select="tei:usg"/>)
                                                      </xsl:if>
                                                   </span>
                                                </div>
                                             </xsl:for-each>
                                        </td>
                                     </tr>
                                 </table>
                              </div>
                           </xsl:for-each>

                        </td>
                     </tr>
                                      
               </xsl:for-each>
               
               <!-- 
                 <tr>
                 <td class="tdSenseHead">Editors</td>
                 <td>
                    <span class="spEditors" alt="Editors">
                       <xsl:for-each select="//ed">
                          <xsl:sort select="."/>
                          <xsl:if test="position()&gt;1">,<xsl:text>&#x2006;</xsl:text></xsl:if>
                          <xsl:choose>
                             <xsl:when test=".='Anton'">A.&#xA0;Anton</xsl:when>
                             <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                         </xsl:choose>
                       </xsl:for-each>
                    </span>
                 </td>
               </tr>
                -->
            </table>
            </xsl:for-each>
            
            <br/><br/>
         </div>
      
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="@target=$var1"><span style="color:red"><xsl:apply-templates/></span></xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>