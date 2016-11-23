library(tidyverse)
library(DiagrammeR)

DiagrammeR("
  graph TD;
           hw{htmlwidget} -->experiments;
           hw -->content;
           experiments -->RMarkdown
           content -->RMarkdown
           RMarkdown -->|R/knitr|Markdown;
           Markdown -->|Pandoc|HTML;
           HTML -->|git push| Github;
           HTML -->|copy/paste| Squarespace ;
           ")


DiagrammeR("
  graph TD;

CremTmG -->LPS
LPS --> |yes|Control;
LPS --> |no|Inflammation;
Inflammation --> OVA1?;
Control -->  OVA2?;




")


grViz("
      
digraph boxes_and_circles{
node [shape = Circle,
      fontname = Helvetica,
      penwidth = 2.0]
'Cre mTmG';LPS;Normal;'bOVA?';RNAseq;'Present OVA within MHC';
Inflammation; 'cOVA?'

'Cre mTmG' -> LPS; 
LPS -> Normal [label = 'Yes' fontname= Helvetica];
LPS -> Inflammation [label = 'No' fontname= Helvetica];
Normal ->'bOVA?';
Inflammation ->'cOVA?';
'bOVA?' -> 'Present OVA within MHC' [label = 'Yes' fontname=Helvetica];
'bOVA?' -> RNAseq [label = 'No' fontname=Helvetica];
'cOVA?' -> 'Present OVA within MHC' [label = 'Yes' fontname=Helvetica];
'cOVA?' -> RNAseq [label = 'No' fontname=Helvetica];
      

}      
      ")






grViz("
      
      digraph boxes_and_circles{
      node [shape = Circle,
      fontname = Helvetica,
      penwidth = 2.0]
      'Cre mTmG';LPS;PBS;'Harvest Tissues';'Cell Digest';'Flow Cytometry';Red;Green;'External OVA';'Cross Presented OVA'


'Cre mTmG' -> {LPS PBS}
 {LPS PBS} -> 'Harvest Tissues';
'Harvest Tissues' -> 'Cell Digest'
'Cell Digest' -> 'Flow Cytometry'
'Flow Cytometry' -> {Red Green}
Green -> {'External OVA' 'Cross Presented OVA'}
Red -> {'External OVA' 'Cross Presented OVA'}
   
      
      }      
      ")




grViz("
      
      digraph boxes_and_circles{

node [shape = Box,
      fontname = Helvetica,
      penwidth = 2.0 ]

Peggy;Technician;'Lab Manager';Students;Undergrad;Grad;Geoffrey;Sean;Jacob;Alex

Peggy->Technician;Peggy ->Students;Peggy ->'Lab Manager'
Students->Grad; Grad-> Sean;Grad->Alex;
Students->Undergrad; Undergrad -> Jacob;
Technician-> Geoffrey;
'Lab Manager'-> Sarika
      
      }      
      ")

nodes_1 <-
  create_nodes(nodes = c("a", "b", "c", "d"),
               label = FALSE,
               type = "lower",
               style = "filled",
               color = "aqua",
               shape = c("circle", "circle",
                         "rectangle", "rectangle"),
               data = c(3.5, 2.6, 9.4, 2.7))

nodes_1


nodes_2 <-
  create_nodes(nodes = c("e", "f", "g", "h"),
               label = FALSE,
               type = "upper",
               style = "filled",
               color = "red",
               shape = "triangle",
               data = c(0.5, 3.9, 3.7, 8.2))

nodes_2

all_nodes <- combine_nodes(nodes_1, nodes_2)

all_nodes

edges_1 <-
  create_edges(from = c("a", "a", "b", "c"),
               to = c("b", "d", "d", "a"),
               rel = "requires",
               color = "green",
               data = c(2.7, 8.9, 2.6, 0.6))

edges_1

edges_2 <-
  create_edges(from = c("e", "g", "h", "h"),
               to = c("g", "h", "f", "e"),
               rel = "receives",
               arrowhead = "dot",
               color = "red")

edges_2

all_edges <- combine_edges(edges_1, edges_2)

all_edges



nodes <-
  create_nodes(nodes = c("a", "b", "c", "d"),
               label = FALSE,
               type = "lower",
               style = "filled",
               color = "aqua",
               shape = c("circle", "circle",
                         "rectangle", "rectangle"),
               data = c(3.5, 2.6, 9.4, 2.7))

edges <-
  create_edges(from = c("a", "b", "c"),
               to = c("d", "c", "a"),
               rel = "leading_to")


graph <-
  create_graph(nodes_df = nodes,
               edges_df = edges,
               node_attrs = "fontname = Helvetica",
               edge_attrs = c("color = blue",
                              "arrowsize = 2"))

graph

render_graph(graph)


set.seed(23)

# Create a node data frame
nodes <-
  create_nodes(nodes = LETTERS,
               type = "letter",
               shape = sample(c("circle", "rectangle"),
                              length(LETTERS),
                              replace = TRUE),
               fillcolor = sample(c("aqua", "gray80",
                                    "pink", "lightgreen",
                                    "azure", "yellow"),
                                  length(LETTERS),
                                  replace = TRUE))

edges <-
  create_edges(from = sample(LETTERS, replace = TRUE),
               to = sample(LETTERS, replace = TRUE),
               rel = "letter_to_letter")


graph <-
  create_graph(nodes_df = nodes,
               edges_df = edges,
               graph_attrs = "layout = neato",
               node_attrs = c("fontname = Helvetica",
                              "style = filled"),
               edge_attrs = c("color = gray20",
                              "arrowsize = 0.5"))

# View the graph in the RStudio Viewer
render_graph(graph)


create_graph(
  graph_attrs = "output = visNetwork") %>%
  add_n_nodes(5, "A") %>%
  add_n_nodes(5, "B") %>%
  add_n_nodes(5, "C") %>%
  add_n_nodes(5, "D") %>%
  add_edge_df(create_edges(1:19, 2:20)) %>%
  render_graph



#OLDER
grViz("
digraph dot {
      
      graph [layout = dot]
      
      node [shape = Box,
      style = filled,
      color = Black,
      fontname = Helvetica,
      penwidth = 2.0]
    
      node [fillcolor = GhostWhite]
      'Cre x mTmG' PBS 
      
      
      
      node [fillcolor = Orange]
        LPS 'Harvest Tissues' 'Cell Digest'
      node [fillcolor = LawnGreen]
        GFP
      node [fillcolor = Red]
        tdTomato     
      node [fillcolor = Aqua]
        OVA

      edge [color = Black]
      'Cre x mTmG' -> {PBS LPS}
      LPS -> 'Harvest Tissues';
      b -> {e f g h i j}
      c -> {k l m n o p}
      d -> {q r s t u v}
      }")


#Complex
grViz("
digraph neato {
      
      graph [layout = dot,
              rankdir=TB]
      
      node [shape = Box,
      style = filled,
      color = Black,
      fontname = Helvetica,
      penwidth = 2.0]
      
      node [fillcolor = GhostWhite]
      a [label= 'Cre x mTmG']; b [label= 'PBS']; e [label= 'Harvest Tissues']; o [label= 'Flow Cytometry']
      
      node [fillcolor = LawnGreen]
      i [label= 'Green']; p [label= 'Green']
      
      node [fillcolor = Red]
      h [label= 'Red']; q [label= 'Red']

      node [fillcolor = Orange]
      c [label= 'LPS']; g [label= 'Flow Cytometry']; f [label= 'Harvest Tissues']

      node [fillcolor = DodgerBlue]
      k [label= 'Cross presented OVA']; m [label= 'Cross presented OVA']; r [label= 'Cross presented OVA']; t [label= 'Cross presented OVA']
      
      node [fillcolor = Aqua]
      j [label= 'External OVA']; l [label= 'External OVA']; s [label= 'External OVA']; u [label= 'External OVA']

      node [fillcolor = Fuchsia]
      n [label= 'RNAseq']

edge [color = Black]
      a -> {b c}
      b -> e
      c-> f
      f->g
      g-> {h i}
      i->{j k} 
      h-> {l m}
      {j k l m r s t u}->n
      e->o
      o->{p q}
      p->{r s}
      q->{t u}
  
      }")






#Simple
 grViz("
      digraph neato {
      
      graph [layout = dot]
      
      node [shape = Box,
      style = filled,
      color = Black,
      fontname = Helvetica,
      penwidth = 2.0]
      
      node [fillcolor = GhostWhite]
      a [label= 'OVA Cre x mTmG']; b [label= 'PBS']; e [label= 'Harvest Tissues']
      
      node [fillcolor = LawnGreen]
      i [label= 'Green']
      
      node [fillcolor = Red]
      h [label= 'Red']
      
      node [fillcolor = Orange]
      c [label= 'LPS']; g [label= 'Flow Cytometry']; f [label= 'Harvest Tissues']
      
      node [fillcolor = DodgerBlue]
      k [label= 'Cross presented \nOVA']; m [label= 'Cross presented \nOVA']
      
      node [fillcolor = Aqua]
      j [label= 'External OVA']; l [label= 'External OVA']
      
      node [fillcolor = Fuchsia]
      n [label= 'RNAseq']
      
      edge [color = Black]
      a -> {b c}
      b -> e
      c-> f
      f->g
      g-> {h i}
      i->{j k} 
      h-> {l m}
      {j k l m}->n
 
      }")


 grViz("
graph severalranks {
       
       node [shape = circle, fixedsize = true, fontcolor = '#555555',
       fontname = Helvetica, fontsize = 7, style = filled, 
       fillcolor ='#AAAAAA', color='#555555', width = 0.12,
       height = 0.12, nodesep = 0.1]
       
       edge [color = '#AAAAAA']
       graph [overlap = true, layout = neato]
       
       node [label='', fillcolor='#000000'] n1
       node [label='', fillcolor='#AAAAAA'] n2
       node [label='', fillcolor='#AAAAAA'] n3
       node [label='', fillcolor='#AAAAAA'] n4
       node [label='', fillcolor='#AAAAAA'] n5
       node [label='', fillcolor='#FFA500'] n6
       node [label='', fillcolor='#FFA500'] n7
       node [label='', fillcolor='#FFA500'] n8
       node [label='', fillcolor='#FF00FF'] n9
       node [label='', fillcolor='#555555'] n10
       node [label='', fillcolor='#FFA500'] n11
       node [label='', fillcolor='#FFA500'] n12
       node [label='', fillcolor='#FFA500'] n13
       node [label='', fillcolor='#0000FF'] n14
       node [label='', fillcolor='#FFA500'] n15
       node [label='', fillcolor='#FFA500'] n16
       node [label='', fillcolor='#0000FF'] n17
       node [label='', fillcolor='#FFA500'] n18
       node [label='', fillcolor='#FFA500'] n19
       node [label='', fillcolor='#0000FF'] n20
       node [label='', fillcolor='#FFA500'] n21
       node [label='', fillcolor='#FFA500'] n22
       node [label='', fillcolor='#0000FF'] n23
       node [label='', fillcolor='#FFA500'] n24
       node [label='', fillcolor='#FFA500'] n25
       node [label='', fillcolor='#0000FF'] n26
       node [label='', fillcolor='#FFA500'] n27
       node [label='', fillcolor='#FFA500'] n28
       node [label='', fillcolor='#0000FF'] n29
       node [label='', fillcolor='#FFA500'] n30
       node [label='', fillcolor='#FFA500'] n31
       node [label='', fillcolor='#0000FF'] n32
       node [label='', fillcolor='#FFA500'] n33
       node [label='', fillcolor='#FFA500'] n34
       node [label='', fillcolor='#0000FF'] n35
       node [label='', fillcolor='#FFA500'] n36
       node [label='', fillcolor='#FFA500'] n37
       node [label='', fillcolor='#0000FF'] n38
       node [label='', fillcolor='#FFA500'] n39
       node [label='', fillcolor='#FFA500'] n40
       node [label='', fillcolor='#FFA500'] n41
       node [label='', fillcolor='#FFA500'] n42
       node [label='', fillcolor='#0000FF'] n43
       node [label='', fillcolor='#FFA500'] n44
       node [label='', fillcolor='#00FFFF'] n45
       node [label='', fillcolor='#FFA500'] n46
       node [label='', fillcolor='#FFA500'] n47
       node [label='', fillcolor='#0000FF'] n48
       node [label='', fillcolor='#0000FF'] n49
       node [label='', fillcolor='#0000FF'] n50
       node [label='', fillcolor='#0000FF'] n51
       node [label='', fillcolor='#0000FF'] n52
       node [label='', fillcolor='#555555'] n53
       node [label='', fillcolor='#0000FF'] n54
       node [label='', fillcolor='#0000FF'] n55
       node [label='', fillcolor='#0000FF'] n56
       node [label='', fillcolor='#0000FF'] n57
       node [label='', fillcolor='#0000FF'] n58
       node [label='', fillcolor='#555555'] n59
       node [label='', fillcolor='#0000FF'] n60
       node [label='', fillcolor='#00FFFF'] n61
       node [label='', fillcolor='#0000FF'] n62
       node [label='', fillcolor='#F0E68C'] n63
       node [label='', fillcolor='#F0E68C'] n64
       node [label='', fillcolor='#0000FF'] n65
       node [label='', fillcolor='#F0E68C'] n66
       node [label='', fillcolor='#0000FF'] n67
       node [label='', fillcolor='#0000FF'] n68
       node [label='', fillcolor='#F0E68C'] n69
       node [label='', fillcolor='#0000FF'] n70
       node [label='', fillcolor='#F0E68C'] n71
       node [label='', fillcolor='#0000FF'] n72
       node [label='', fillcolor='#F0E68C'] n73
       node [label='', fillcolor='#0000FF'] n74
       node [label='', fillcolor='#555555'] n75
       node [label='', fillcolor='#F0E68C'] n76
       node [label='', fillcolor='#0000FF'] n77
       node [label='', fillcolor='#F0E68C'] n78
       node [label='', fillcolor='#0000FF'] n79
       node [label='', fillcolor='#F0E68C'] n80
       node [label='', fillcolor='#0000FF'] n81
       node [label='', fillcolor='#F0E68C'] n82
       node [label='', fillcolor='#0000FF'] n83
       node [label='', fillcolor='#F0E68C'] n84
       node [label='', fillcolor='#0000FF'] n85
       node [label='', fillcolor='#0000FF'] n86
       node [label='', fillcolor='#F0E68C'] n87
       node [label='', fillcolor='#0000FF'] n88
       node [label='', fillcolor='#F0E68C'] n89
       node [label='', fillcolor='#0000FF'] n90
       node [label='', fillcolor='#0000FF'] n91
       node [label='', fillcolor='#F0E68C'] n92
       node [label='', fillcolor='#0000FF'] n93
       node [label='', fillcolor='#0000FF'] n94
       node [label='', fillcolor='#F0E68C'] n95
       node [label='', fillcolor='#0000FF'] n96
       node [label='', fillcolor='#0000FF'] n97
       node [label='', fillcolor='#00FFFF'] n98
       node [label='', fillcolor='#0000FF'] n99
       node [label='', fillcolor='#F0E68C'] n100
       node [label='', fillcolor='#F0E68C'] n101
       node [label='', fillcolor='#0000FF'] n102
       node [label='', fillcolor='#0000FF'] n103
       node [label='', fillcolor='#F0E68C'] n104
       node [label='', fillcolor='#0000FF'] n105
       node [label='', fillcolor='#0000FF'] n106
       node [label='', fillcolor='#F0E68C'] n107
       node [label='', fillcolor='#0000FF'] n108
       node [label='', fillcolor='#F0E68C'] n109
       node [label='', fillcolor='#0000FF'] n110
       node [label='', fillcolor='#F0E68C'] n111
       node [label='', fillcolor='#0000FF'] n112
       node [label='', fillcolor='#F0E68C'] n113
       node [label='', fillcolor='#0000FF'] n114
       node [label='', fillcolor='#F0E68C'] n115
       node [label='', fillcolor='#0000FF'] n116
       node [label='', fillcolor='#F0E68C'] n117
       node [label='', fillcolor='#0000FF'] n118
       node [label='', fillcolor='#F0E68C'] n119
       node [label='', fillcolor='#0000FF'] n120
       node [label='', fillcolor='#F0E68C'] n121
       node [label='', fillcolor='#0000FF'] n122
       node [label='', fillcolor='#F0E68C'] n123
       node [label='', fillcolor='#0000FF'] n124
       node [label='', fillcolor='#F0E68C'] n125
       node [label='', fillcolor='#0000FF'] n126
       node [label='', fillcolor='#F0E68C'] n127
       node [label='', fillcolor='#0000FF'] n128
       node [label='', fillcolor='#F0E68C'] n129
       node [label='', fillcolor='#0000FF'] n130
       node [label='', fillcolor='#F0E68C'] n131
       node [label='', fillcolor='#0000FF'] n132
       node [label='', fillcolor='#F0E68C'] n133
       node [label='', fillcolor='#0000FF'] n134
       node [label='', fillcolor='#F0E68C'] n135
       node [label='', fillcolor='#0000FF'] n136
       node [label='', fillcolor='#F0E68C'] n137
       node [label='', fillcolor='#0000FF'] n138
       node [label='', fillcolor='#555555'] n139
       node [label='', fillcolor='#0000FF'] n140
       node [label='', fillcolor='#F0E68C'] n141
       node [label='', fillcolor='#0000FF'] n142
       node [label='', fillcolor='#F0E68C'] n143
       node [label='', fillcolor='#0000FF'] n144
       node [label='', fillcolor='#F0E68C'] n145
       node [label='', fillcolor='#0000FF'] n146
       node [label='', fillcolor='#F0E68C'] n147
       node [label='', fillcolor='#0000FF'] n148
       node [label='', fillcolor='#F0E68C'] n149
       node [label='', fillcolor='#0000FF'] n150
       node [label='', fillcolor='#555555'] n151
       node [label='', fillcolor='#0000FF'] n152
       node [label='', fillcolor='#555555'] n153
       node [label='', fillcolor='#0000FF'] n154
       node [label='', fillcolor='#00FFFF'] n155
       node [label='', fillcolor='#0000FF'] n156
       node [label='', fillcolor='#F0E68C'] n157
       node [label='', fillcolor='#F0E68C'] n158
       node [label='', fillcolor='#0000FF'] n159
       node [label='', fillcolor='#F0E68C'] n160
       node [label='', fillcolor='#0000FF'] n161
       node [label='', fillcolor='#F0E68C'] n162
       node [label='', fillcolor='#0000FF'] n163
       node [label='', fillcolor='#0000FF'] n164
       node [label='', fillcolor='#F0E68C'] n165
       node [label='', fillcolor='#0000FF'] n166
       node [label='', fillcolor='#F0E68C'] n167
       node [label='', fillcolor='#0000FF'] n168
       node [label='', fillcolor='#F0E68C'] n169
       node [label='', fillcolor='#0000FF'] n170
       node [label='', fillcolor='#F0E68C'] n171
       node [label='', fillcolor='#0000FF'] n172
       node [label='', fillcolor='#F0E68C'] n173
       node [label='', fillcolor='#0000FF'] n174
       node [label='', fillcolor='#F0E68C'] n175
       node [label='', fillcolor='#0000FF'] n176
       node [label='', fillcolor='#F0E68C'] n177
       node [label='', fillcolor='#0000FF'] n178
       node [label='', fillcolor='#F0E68C'] n179
       node [label='', fillcolor='#0000FF'] n180
       node [label='', fillcolor='#0000FF'] n181
       node [label='', fillcolor='#0000FF'] n182
       node [label='', fillcolor='#F0E68C'] n183
       node [label='', fillcolor='#0000FF'] n184
       node [label='', fillcolor='#00FFFF'] n185
       node [label='', fillcolor='#0000FF'] n186
       node [label='', fillcolor='#F0E68C'] n187
       node [label='', fillcolor='#F0E68C'] n188
       node [label='', fillcolor='#0000FF'] n189
       node [label='', fillcolor='#F0E68C'] n190
       node [label='', fillcolor='#0000FF'] n191
       node [label='', fillcolor='#0000FF'] n192
       node [label='', fillcolor='#F0E68C'] n193
       node [label='', fillcolor='#0000FF'] n194
       node [label='', fillcolor='#F0E68C'] n195
       node [label='', fillcolor='#0000FF'] n196
       node [label='', fillcolor='#F0E68C'] n197
       node [label='', fillcolor='#F0E68C'] n198
       node [label='', fillcolor='#0000FF'] n199
       node [label='', fillcolor='#F0E68C'] n200
       node [label='', fillcolor='#0000FF'] n201
       node [label='', fillcolor='#F0E68C'] n202
       node [label='', fillcolor='#0000FF'] n203
       node [label='', fillcolor='#0000FF'] n204
       node [label='', fillcolor='#F0E68C'] n205
       node [label='', fillcolor='#0000FF'] n206
       node [label='', fillcolor='#0000FF'] n207
       node [label='', fillcolor='#F0E68C'] n208
       node [label='', fillcolor='#0000FF'] n209
       node [label='', fillcolor='#F0E68C'] n210
       node [label='', fillcolor='#0000FF'] n211
       node [label='', fillcolor='#F0E68C'] n212
       node [label='', fillcolor='#0000FF'] n213
       node [label='', fillcolor='#F0E68C'] n214
       node [label='', fillcolor='#0000FF'] n215
       node [label='', fillcolor='#0000FF'] n216
       node [label='', fillcolor='#F0E68C'] n217
       node [label='', fillcolor='#0000FF'] n218
       node [label='', fillcolor='#0000FF'] n219
       node [label='', fillcolor='#F0E68C'] n220
       node [label='', fillcolor='#0000FF'] n221
       node [label='', fillcolor='#F0E68C'] n222
       node [label='', fillcolor='#0000FF'] n223
       node [label='', fillcolor='#F0E68C'] n224
       node [label='', fillcolor='#0000FF'] n225
       node [label='', fillcolor='#F0E68C'] n226
       node [label='', fillcolor='#0000FF'] n227
       node [label='', fillcolor='#F0E68C'] n228
       node [label='', fillcolor='#0000FF'] n229
       node [label='', fillcolor='#00FFFF'] n230
       node [label='', fillcolor='#0000FF'] n231
       node [label='', fillcolor='#F0E68C'] n232
       node [label='', fillcolor='#F0E68C'] n233
       node [label='', fillcolor='#0000FF'] n234
       node [label='', fillcolor='#F0E68C'] n235
       node [label='', fillcolor='#0000FF'] n236
       node [label='', fillcolor='#0000FF'] n237
       node [label='', fillcolor='#F0E68C'] n238
       node [label='', fillcolor='#0000FF'] n239
       node [label='', fillcolor='#0000FF'] n240
       node [label='', fillcolor='#555555'] n241
       node [label='', fillcolor='#0000FF'] n242
       node [label='', fillcolor='#555555'] n243
       node [label='', fillcolor='#0000FF'] n244
       node [label='', fillcolor='#555555'] n245
       node [label='', fillcolor='#F0E68C'] n246
       node [label='', fillcolor='#0000FF'] n247
       node [label='', fillcolor='#F0E68C'] n248
       node [label='', fillcolor='#0000FF'] n249
       node [label='', fillcolor='#00FFFF'] n250
       node [label='', fillcolor='#0000FF'] n251
       node [label='', fillcolor='#F0E68C'] n252
       node [label='', fillcolor='#F0E68C'] n253
       node [label='', fillcolor='#0000FF'] n254
       node [label='', fillcolor='#F0E68C'] n255
       node [label='', fillcolor='#0000FF'] n256
       node [label='', fillcolor='#F0E68C'] n257
       node [label='', fillcolor='#0000FF'] n258
       node [label='', fillcolor='#0000FF'] n259
       node [label='', fillcolor='#F0E68C'] n260
       node [label='', fillcolor='#0000FF'] n261
       node [label='', fillcolor='#F0E68C'] n262
       node [label='', fillcolor='#0000FF'] n263
       node [label='', fillcolor='#F0E68C'] n264
       node [label='', fillcolor='#0000FF'] n265
       node [label='', fillcolor='#F0E68C'] n266
       node [label='', fillcolor='#0000FF'] n267
       node [label='', fillcolor='#F0E68C'] n268
       node [label='', fillcolor='#0000FF'] n269
       node [label='', fillcolor='#F0E68C'] n270
       node [label='', fillcolor='#0000FF'] n271
       node [label='', fillcolor='#F0E68C'] n272
       node [label='', fillcolor='#0000FF'] n273
       node [label='', fillcolor='#F0E68C'] n274
       node [label='', fillcolor='#0000FF'] n275
       node [label='', fillcolor='#F0E68C'] n276
       node [label='', fillcolor='#0000FF'] n277
       node [label='', fillcolor='#0000FF'] n278
       node [label='', fillcolor='#F0E68C'] n279
       node [label='', fillcolor='#0000FF'] n280
       node [label='', fillcolor='#F0E68C'] n281
       node [label='', fillcolor='#0000FF'] n282
       node [label='', fillcolor='#0000FF'] n283
       node [label='', fillcolor='#F0E68C'] n284
       node [label='', fillcolor='#0000FF'] n285
       node [label='', fillcolor='#0000FF'] n286
       node [label='', fillcolor='#F0E68C'] n287
       node [label='', fillcolor='#0000FF'] n288
       node [label='', fillcolor='#F0E68C'] n289
       node [label='', fillcolor='#0000FF'] n290
       node [label='', fillcolor='#F0E68C'] n291
       node [label='', fillcolor='#0000FF'] n292
       node [label='', fillcolor='#F0E68C'] n293
       node [label='', fillcolor='#0000FF'] n294
       node [label='', fillcolor='#F0E68C'] n295
       node [label='', fillcolor='#0000FF'] n296
       node [label='', fillcolor='#F0E68C'] n297
       node [label='', fillcolor='#0000FF'] n298
       node [label='', fillcolor='#F0E68C'] n299
       node [label='', fillcolor='#0000FF'] n300
       node [label='', fillcolor='#F0E68C'] n301
       node [label='', fillcolor='#0000FF'] n302
       node [label='', fillcolor='#F0E68C'] n303
       node [label='', fillcolor='#0000FF'] n304
       node [label='', fillcolor='#F0E68C'] n305
       node [label='', fillcolor='#0000FF'] n306
       node [label='', fillcolor='#F0E68C'] n307
       node [label='', fillcolor='#0000FF'] n308
       node [label='', fillcolor='#F0E68C'] n309
       node [label='', fillcolor='#0000FF'] n310
       node [label='', fillcolor='#F0E68C'] n311
       node [label='', fillcolor='#0000FF'] n312
       node [label='', fillcolor='#F0E68C'] n313
       node [label='', fillcolor='#0000FF'] n314
       node [label='', fillcolor='#F0E68C'] n315
       node [label='', fillcolor='#0000FF'] n316
       node [label='', fillcolor='#F0E68C'] n317
       node [label='', fillcolor='#0000FF'] n318
       node [label='', fillcolor='#F0E68C'] n319
       node [label='', fillcolor='#0000FF'] n320
       node [label='', fillcolor='#F0E68C'] n321
       node [label='', fillcolor='#0000FF'] n322
       node [label='', fillcolor='#F0E68C'] n323
       node [label='', fillcolor='#0000FF'] n324
       node [label='', fillcolor='#00FFFF'] n325
       node [label='', fillcolor='#0000FF'] n326
       node [label='', fillcolor='#F0E68C'] n327
       node [label='', fillcolor='#F0E68C'] n328
       node [label='', fillcolor='#0000FF'] n329
       node [label='', fillcolor='#0000FF'] n330
       node [label='', fillcolor='#F0E68C'] n331
       node [label='', fillcolor='#555555'] n332
       node [label='', fillcolor='#0000FF'] n333
       node [label='', fillcolor='#0000FF'] n334
       node [label='', fillcolor='#0000FF'] n335
       node [label='', fillcolor='#F0E68C'] n336
       node [label='', fillcolor='#0000FF'] n337
       node [label='', fillcolor='#0000FF'] n338
       node [label='', fillcolor='#F0E68C'] n339
       node [label='', fillcolor='#0000FF'] n340
       node [label='', fillcolor='#0000FF'] n341
       node [label='', fillcolor='#0000FF'] n342
       node [label='', fillcolor='#F0E68C'] n343
       node [label='', fillcolor='#0000FF'] n344
       node [label='', fillcolor='#555555'] n345
       node [label='', fillcolor='#00FFFF'] n346
       node [label='', fillcolor='#0000FF'] n347
       node [label='', fillcolor='#F0E68C'] n348
       node [label='', fillcolor='#F0E68C'] n349
       node [label='', fillcolor='#0000FF'] n350
       node [label='', fillcolor='#F0E68C'] n351
       node [label='', fillcolor='#0000FF'] n352
       node [label='', fillcolor='#0000FF'] n353
       node [label='', fillcolor='#F0E68C'] n354
       node [label='', fillcolor='#0000FF'] n355
       node [label='', fillcolor='#F0E68C'] n356
       node [label='', fillcolor='#0000FF'] n357
       node [label='', fillcolor='#F0E68C'] n358
       node [label='', fillcolor='#0000FF'] n359
       node [label='', fillcolor='#F0E68C'] n360
       node [label='', fillcolor='#0000FF'] n361
       node [label='', fillcolor='#F0E68C'] n362
       node [label='', fillcolor='#0000FF'] n363
       node [label='', fillcolor='#F0E68C'] n364
       node [label='', fillcolor='#0000FF'] n365
       node [label='', fillcolor='#F0E68C'] n366
       node [label='', fillcolor='#0000FF'] n367
       node [label='', fillcolor='#00FFFF'] n368
       node [label='', fillcolor='#0000FF'] n369
       node [label='', fillcolor='#F0E68C'] n370
       node [label='', fillcolor='#F0E68C'] n371
       node [label='', fillcolor='#0000FF'] n372
       node [label='', fillcolor='#F0E68C'] n373
       node [label='', fillcolor='#0000FF'] n374
       node [label='', fillcolor='#F0E68C'] n375
       node [label='', fillcolor='#0000FF'] n376
       node [label='', fillcolor='#00FFFF'] n377
       node [label='', fillcolor='#0000FF'] n378
       node [label='', fillcolor='#F0E68C'] n379
       node [label='', fillcolor='#F0E68C'] n380
       node [label='', fillcolor='#0000FF'] n381
       node [label='', fillcolor='#F0E68C'] n382
       node [label='', fillcolor='#0000FF'] n383
       node [label='', fillcolor='#FF00FF'] n384
       node [label='', fillcolor='#F0E68C'] n385
       node [label='', fillcolor='#0000FF'] n386
       node [label='', fillcolor='#F0E68C'] n387
       node [label='', fillcolor='#0000FF'] n388
       node [label='', fillcolor='#FF00FF'] n389
       node [label='', fillcolor='#F0E68C'] n390
       node [label='', fillcolor='#0000FF'] n391
       node [label='', fillcolor='#FF00FF'] n392
       node [label='', fillcolor='#F0E68C'] n393
       node [label='', fillcolor='#0000FF'] n394
       node [label='', fillcolor='#FF00FF'] n395
       node [label='', fillcolor='#F0E68C'] n396
       node [label='', fillcolor='#0000FF'] n397
       node [label='', fillcolor='#FF00FF'] n398
       node [label='', fillcolor='#F0E68C'] n399
       node [label='', fillcolor='#0000FF'] n400
       node [label='', fillcolor='#FF00FF'] n401
       node [label='', fillcolor='#F0E68C'] n402
       node [label='', fillcolor='#0000FF'] n403
       node [label='', fillcolor='#FF00FF'] n404
       node [label='', fillcolor='#F0E68C'] n405
       node [label='', fillcolor='#0000FF'] n406
       node [label='', fillcolor='#FF00FF'] n407
       n1 -- n2 [len=0.800]
       n1 -- n5 [len=0.800]
       n2 -- n3 [len=0.728]
       n2 -- n4 [len=0.728]
       n5 -- n6 [len=0.728]
       n6 -- n7 [len=0.656]
       n6 -- n46 [len=0.656]
       n7 -- n8 [len=0.583]
       n7 -- n44 [len=0.583]
       n8 -- n9 [len=0.511]
       n8 -- n10 [len=0.511]
       n10 -- n11 [len=0.439]
       n11 -- n12 [len=0.367]
       n11 -- n15 [len=0.367]
       n11 -- n18 [len=0.367]
       n11 -- n21 [len=0.367]
       n11 -- n24 [len=0.367]
       n11 -- n27 [len=0.367]
       n11 -- n30 [len=0.367]
       n11 -- n33 [len=0.367]
       n11 -- n36 [len=0.367]
       n11 -- n39 [len=0.367]
       n11 -- n41 [len=0.367]
       n12 -- n13 [len=0.294]
       n13 -- n14 [len=0.222]
       n15 -- n16 [len=0.294]
       n16 -- n17 [len=0.222]
       n18 -- n19 [len=0.294]
       n19 -- n20 [len=0.222]
       n21 -- n22 [len=0.294]
       n22 -- n23 [len=0.222]
       n24 -- n25 [len=0.294]
       n25 -- n26 [len=0.222]
       n27 -- n28 [len=0.294]
       n28 -- n29 [len=0.222]
       n30 -- n31 [len=0.294]
       n31 -- n32 [len=0.222]
       n33 -- n34 [len=0.294]
       n34 -- n35 [len=0.222]
       n36 -- n37 [len=0.294]
       n37 -- n38 [len=0.222]
       n39 -- n40 [len=0.294]
       n41 -- n42 [len=0.294]
       n42 -- n43 [len=0.222]
       n44 -- n45 [len=0.511]
       n46 -- n47 [len=0.583]
       n47 -- n48 [len=0.511]
       n47 -- n49 [len=0.511]
       n47 -- n50 [len=0.511]
       n47 -- n51 [len=0.511]
       n47 -- n52 [len=0.511]
       n47 -- n53 [len=0.511]
       n47 -- n54 [len=0.511]
       n47 -- n55 [len=0.511]
       n47 -- n56 [len=0.511]
       n47 -- n57 [len=0.511]
       n47 -- n58 [len=0.511]
       n47 -- n59 [len=0.511]
       n47 -- n61 [len=0.511]
       n47 -- n63 [len=0.511]
       n47 -- n98 [len=0.511]
       n47 -- n100 [len=0.511]
       n47 -- n155 [len=0.511]
       n47 -- n157 [len=0.511]
       n47 -- n185 [len=0.511]
       n47 -- n187 [len=0.511]
       n47 -- n230 [len=0.511]
       n47 -- n232 [len=0.511]
       n47 -- n250 [len=0.511]
       n47 -- n252 [len=0.511]
       n47 -- n325 [len=0.511]
       n47 -- n327 [len=0.511]
       n47 -- n346 [len=0.511]
       n47 -- n348 [len=0.511]
       n47 -- n368 [len=0.511]
       n47 -- n370 [len=0.511]
       n47 -- n377 [len=0.511]
       n47 -- n379 [len=0.511]
       n59 -- n60 [len=0.439]
       n61 -- n62 [len=0.439]
       n63 -- n64 [len=0.439]
       n63 -- n66 [len=0.439]
       n63 -- n69 [len=0.439]
       n63 -- n71 [len=0.439]
       n63 -- n73 [len=0.439]
       n63 -- n76 [len=0.439]
       n63 -- n78 [len=0.439]
       n63 -- n80 [len=0.439]
       n63 -- n82 [len=0.439]
       n63 -- n84 [len=0.439]
       n63 -- n87 [len=0.439]
       n63 -- n89 [len=0.439]
       n63 -- n92 [len=0.439]
       n63 -- n95 [len=0.439]
       n64 -- n65 [len=0.367]
       n66 -- n67 [len=0.367]
       n66 -- n68 [len=0.367]
       n69 -- n70 [len=0.367]
       n71 -- n72 [len=0.367]
       n73 -- n74 [len=0.367]
       n73 -- n75 [len=0.367]
       n76 -- n77 [len=0.367]
       n78 -- n79 [len=0.367]
       n80 -- n81 [len=0.367]
       n82 -- n83 [len=0.367]
       n84 -- n85 [len=0.367]
       n85 -- n86 [len=0.294]
       n87 -- n88 [len=0.367]
       n89 -- n90 [len=0.367]
       n90 -- n91 [len=0.294]
       n92 -- n93 [len=0.367]
       n93 -- n94 [len=0.294]
       n95 -- n96 [len=0.367]
       n96 -- n97 [len=0.294]
       n98 -- n99 [len=0.439]
       n100 -- n101 [len=0.439]
       n100 -- n104 [len=0.439]
       n100 -- n107 [len=0.439]
       n100 -- n109 [len=0.439]
       n100 -- n111 [len=0.439]
       n100 -- n113 [len=0.439]
       n100 -- n115 [len=0.439]
       n100 -- n117 [len=0.439]
       n100 -- n119 [len=0.439]
       n100 -- n121 [len=0.439]
       n100 -- n123 [len=0.439]
       n100 -- n125 [len=0.439]
       n100 -- n127 [len=0.439]
       n100 -- n129 [len=0.439]
       n100 -- n131 [len=0.439]
       n100 -- n133 [len=0.439]
       n100 -- n135 [len=0.439]
       n100 -- n137 [len=0.439]
       n100 -- n141 [len=0.439]
       n100 -- n143 [len=0.439]
       n100 -- n145 [len=0.439]
       n100 -- n147 [len=0.439]
       n100 -- n149 [len=0.439]
       n101 -- n102 [len=0.367]
       n101 -- n103 [len=0.367]
       n104 -- n105 [len=0.367]
       n104 -- n106 [len=0.367]
       n107 -- n108 [len=0.367]
       n109 -- n110 [len=0.367]
       n111 -- n112 [len=0.367]
       n113 -- n114 [len=0.367]
       n115 -- n116 [len=0.367]
       n117 -- n118 [len=0.367]
       n119 -- n120 [len=0.367]
       n121 -- n122 [len=0.367]
       n123 -- n124 [len=0.367]
       n125 -- n126 [len=0.367]
       n127 -- n128 [len=0.367]
       n129 -- n130 [len=0.367]
       n131 -- n132 [len=0.367]
       n133 -- n134 [len=0.367]
       n135 -- n136 [len=0.367]
       n137 -- n138 [len=0.367]
       n137 -- n139 [len=0.367]
       n137 -- n140 [len=0.367]
       n141 -- n142 [len=0.367]
       n143 -- n144 [len=0.367]
       n145 -- n146 [len=0.367]
       n147 -- n148 [len=0.367]
       n149 -- n150 [len=0.367]
       n149 -- n151 [len=0.367]
       n149 -- n152 [len=0.367]
       n149 -- n153 [len=0.367]
       n149 -- n154 [len=0.367]
       n155 -- n156 [len=0.439]
       n157 -- n158 [len=0.439]
       n157 -- n160 [len=0.439]
       n157 -- n162 [len=0.439]
       n157 -- n165 [len=0.439]
       n157 -- n167 [len=0.439]
       n157 -- n169 [len=0.439]
       n157 -- n171 [len=0.439]
       n157 -- n173 [len=0.439]
       n157 -- n175 [len=0.439]
       n157 -- n177 [len=0.439]
       n157 -- n179 [len=0.439]
       n157 -- n183 [len=0.439]
       n158 -- n159 [len=0.367]
       n160 -- n161 [len=0.367]
       n162 -- n163 [len=0.367]
       n162 -- n164 [len=0.367]
       n165 -- n166 [len=0.367]
       n167 -- n168 [len=0.367]
       n169 -- n170 [len=0.367]
       n171 -- n172 [len=0.367]
       n173 -- n174 [len=0.367]
       n175 -- n176 [len=0.367]
       n177 -- n178 [len=0.367]
       n179 -- n180 [len=0.367]
       n179 -- n181 [len=0.367]
       n179 -- n182 [len=0.367]
       n183 -- n184 [len=0.367]
       n185 -- n186 [len=0.439]
       n187 -- n188 [len=0.439]
       n187 -- n190 [len=0.439]
       n187 -- n193 [len=0.439]
       n187 -- n195 [len=0.439]
       n187 -- n197 [len=0.439]
       n187 -- n198 [len=0.439]
       n187 -- n200 [len=0.439]
       n187 -- n202 [len=0.439]
       n187 -- n205 [len=0.439]
       n187 -- n208 [len=0.439]
       n187 -- n210 [len=0.439]
       n187 -- n212 [len=0.439]
       n187 -- n214 [len=0.439]
       n187 -- n217 [len=0.439]
       n187 -- n220 [len=0.439]
       n187 -- n222 [len=0.439]
       n187 -- n224 [len=0.439]
       n187 -- n226 [len=0.439]
       n187 -- n228 [len=0.439]
       n188 -- n189 [len=0.367]
       n190 -- n191 [len=0.367]
       n190 -- n192 [len=0.367]
       n193 -- n194 [len=0.367]
       n195 -- n196 [len=0.367]
       n198 -- n199 [len=0.367]
       n200 -- n201 [len=0.367]
       n202 -- n203 [len=0.367]
       n202 -- n204 [len=0.367]
       n205 -- n206 [len=0.367]
       n205 -- n207 [len=0.367]
       n208 -- n209 [len=0.367]
       n210 -- n211 [len=0.367]
       n212 -- n213 [len=0.367]
       n214 -- n215 [len=0.367]
       n214 -- n216 [len=0.367]
       n217 -- n218 [len=0.367]
       n217 -- n219 [len=0.367]
       n220 -- n221 [len=0.367]
       n222 -- n223 [len=0.367]
       n224 -- n225 [len=0.367]
       n226 -- n227 [len=0.367]
       n228 -- n229 [len=0.367]
       n230 -- n231 [len=0.439]
       n232 -- n233 [len=0.439]
       n232 -- n235 [len=0.439]
       n232 -- n238 [len=0.439]
       n232 -- n246 [len=0.439]
       n232 -- n248 [len=0.439]
       n233 -- n234 [len=0.367]
       n235 -- n236 [len=0.367]
       n235 -- n237 [len=0.367]
       n238 -- n239 [len=0.367]
       n238 -- n240 [len=0.367]
       n238 -- n242 [len=0.367]
       n238 -- n244 [len=0.367]
       n240 -- n241 [len=0.294]
       n242 -- n243 [len=0.294]
       n244 -- n245 [len=0.294]
       n246 -- n247 [len=0.367]
       n248 -- n249 [len=0.367]
       n250 -- n251 [len=0.439]
       n252 -- n253 [len=0.439]
       n252 -- n255 [len=0.439]
       n252 -- n257 [len=0.439]
       n252 -- n260 [len=0.439]
       n252 -- n262 [len=0.439]
       n252 -- n264 [len=0.439]
       n252 -- n266 [len=0.439]
       n252 -- n268 [len=0.439]
       n252 -- n270 [len=0.439]
       n252 -- n272 [len=0.439]
       n252 -- n274 [len=0.439]
       n252 -- n276 [len=0.439]
       n252 -- n279 [len=0.439]
       n252 -- n281 [len=0.439]
       n252 -- n284 [len=0.439]
       n252 -- n287 [len=0.439]
       n252 -- n289 [len=0.439]
       n252 -- n291 [len=0.439]
       n252 -- n293 [len=0.439]
       n252 -- n295 [len=0.439]
       n252 -- n297 [len=0.439]
       n252 -- n299 [len=0.439]
       n252 -- n301 [len=0.439]
       n252 -- n303 [len=0.439]
       n252 -- n305 [len=0.439]
       n252 -- n307 [len=0.439]
       n252 -- n309 [len=0.439]
       n252 -- n311 [len=0.439]
       n252 -- n313 [len=0.439]
       n252 -- n315 [len=0.439]
       n252 -- n317 [len=0.439]
       n252 -- n319 [len=0.439]
       n252 -- n321 [len=0.439]
       n252 -- n323 [len=0.439]
       n253 -- n254 [len=0.367]
       n255 -- n256 [len=0.367]
       n257 -- n258 [len=0.367]
       n257 -- n259 [len=0.367]
       n260 -- n261 [len=0.367]
       n262 -- n263 [len=0.367]
       n264 -- n265 [len=0.367]
       n266 -- n267 [len=0.367]
       n268 -- n269 [len=0.367]
       n270 -- n271 [len=0.367]
       n272 -- n273 [len=0.367]
       n274 -- n275 [len=0.367]
       n276 -- n277 [len=0.367]
       n276 -- n278 [len=0.367]
       n279 -- n280 [len=0.367]
       n281 -- n282 [len=0.367]
       n281 -- n283 [len=0.367]
       n284 -- n285 [len=0.367]
       n284 -- n286 [len=0.367]
       n287 -- n288 [len=0.367]
       n289 -- n290 [len=0.367]
       n291 -- n292 [len=0.367]
       n293 -- n294 [len=0.367]
       n295 -- n296 [len=0.367]
       n297 -- n298 [len=0.367]
       n299 -- n300 [len=0.367]
       n301 -- n302 [len=0.367]
       n303 -- n304 [len=0.367]
       n305 -- n306 [len=0.367]
       n307 -- n308 [len=0.367]
       n309 -- n310 [len=0.367]
       n311 -- n312 [len=0.367]
       n313 -- n314 [len=0.367]
       n315 -- n316 [len=0.367]
       n317 -- n318 [len=0.367]
       n319 -- n320 [len=0.367]
       n321 -- n322 [len=0.367]
       n323 -- n324 [len=0.367]
       n325 -- n326 [len=0.439]
       n327 -- n328 [len=0.439]
       n327 -- n331 [len=0.439]
       n327 -- n336 [len=0.439]
       n327 -- n339 [len=0.439]
       n327 -- n343 [len=0.439]
       n328 -- n329 [len=0.367]
       n328 -- n330 [len=0.367]
       n331 -- n332 [len=0.367]
       n331 -- n333 [len=0.367]
       n331 -- n334 [len=0.367]
       n331 -- n335 [len=0.367]
       n336 -- n337 [len=0.367]
       n336 -- n338 [len=0.367]
       n339 -- n340 [len=0.367]
       n339 -- n341 [len=0.367]
       n339 -- n342 [len=0.367]
       n343 -- n344 [len=0.367]
       n344 -- n345 [len=0.294]
       n346 -- n347 [len=0.439]
       n348 -- n349 [len=0.439]
       n348 -- n351 [len=0.439]
       n348 -- n354 [len=0.439]
       n348 -- n356 [len=0.439]
       n348 -- n358 [len=0.439]
       n348 -- n360 [len=0.439]
       n348 -- n362 [len=0.439]
       n348 -- n364 [len=0.439]
       n348 -- n366 [len=0.439]
       n349 -- n350 [len=0.367]
       n351 -- n352 [len=0.367]
       n351 -- n353 [len=0.367]
       n354 -- n355 [len=0.367]
       n356 -- n357 [len=0.367]
       n358 -- n359 [len=0.367]
       n360 -- n361 [len=0.367]
       n362 -- n363 [len=0.367]
       n364 -- n365 [len=0.367]
       n366 -- n367 [len=0.367]
       n368 -- n369 [len=0.439]
       n370 -- n371 [len=0.439]
       n370 -- n373 [len=0.439]
       n370 -- n375 [len=0.439]
       n371 -- n372 [len=0.367]
       n373 -- n374 [len=0.367]
       n375 -- n376 [len=0.367]
       n377 -- n378 [len=0.439]
       n379 -- n380 [len=0.439]
       n379 -- n382 [len=0.439]
       n379 -- n385 [len=0.439]
       n379 -- n387 [len=0.439]
       n379 -- n390 [len=0.439]
       n379 -- n393 [len=0.439]
       n379 -- n396 [len=0.439]
       n379 -- n399 [len=0.439]
       n379 -- n402 [len=0.439]
       n379 -- n405 [len=0.439]
       n380 -- n381 [len=0.367]
       n382 -- n383 [len=0.367]
       n383 -- n384 [len=0.294]
       n385 -- n386 [len=0.367]
       n387 -- n388 [len=0.367]
       n388 -- n389 [len=0.294]
       n390 -- n391 [len=0.367]
       n391 -- n392 [len=0.294]
       n393 -- n394 [len=0.367]
       n394 -- n395 [len=0.294]
       n396 -- n397 [len=0.367]
       n397 -- n398 [len=0.294]
       n399 -- n400 [len=0.367]
       n400 -- n401 [len=0.294]
       n402 -- n403 [len=0.367]
       n403 -- n404 [len=0.294]
       n405 -- n406 [len=0.367]
       n406 -- n407 [len=0.294]
       }")


