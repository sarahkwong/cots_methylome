# **Generating Circos Plot**

---

## **Data layers in the plot**

The Circos plot includes:

- **Karyotype**: For this plot, the top 10 largest scaffolds were selected.
- **Methylation Levels**: 3 heatmap tracks showing average methylation in 100k bins, for the 3 specimens.
- **TE Density**: Transposable element density in 100k windows.
- **Gene Density**: Gene density in 100k windows.

---

## **Configuration file**

Below is the full content of `circos.conf`.

```conf
# circos.conf

karyotype = /path/to/karyotype/

chromosomes_display_default = no
chromosomes = NW_019091355.1;NW_019091356.1;NW_019091357.1;NW_019091358.1;NW_019091359.1;NW_019091360.1;NW_019091361.1;NW_019091362.1;NW_019091363.1;NW_019091364.1

<ideogram>

<spacing>
default = 0.005r

  <pairwise NW_019091355.1 NW_019091364.1>
   spacing = 10r 
  </pairwise>

</spacing>

radius    = 0.8r
thickness = 20p
fill      = yes
color = dgrey
stroke_color     = dgrey
stroke_thickness = 2p

show_label       = yes
# see etc/fonts.conf for list of font names
label_font       = semibold
label_radius     = 1r + 150p
label_size       = 45
label_parallel   = yes

</ideogram>

show_ticks          = yes
show_tick_labels    = yes

<ticks>
radius           = 1r
color            = black
thickness        = 5p
multiplier       = 1e-5

# %d   - integer
# %f   - float
# %.1f - float with one decimal
# %.2f - float with two decimals
#
# for other formats, see https://perldoc.perl.org/functions/sprintf.html

format           = %d

<tick>
spacing        = 1000000
size           = 20p
show_label 	= yes
label_size 	= 40p
label_offset 	= 10p
</tick>

</ticks>


<plots>

<plot>
type = heatmap
file = /path/to/methylation1.bed
r1   = 0.99r
r0   = 0.91r
extend_bin = no
color = oranges-9-seq-1, oranges-9-seq-2, oranges-9-seq-3, oranges-9-seq-4, oranges-9-seq-5, oranges-9-seq-6, oranges-9-seq-7, oranges-9-seq-8, oranges-9-seq-9
</plot>

<plot>
type = heatmap
file = /path/to/methylation2.bed
r1   = 0.88r
r0   = 0.80r
extend_bin = no
color = oranges-9-seq-1, oranges-9-seq-2, oranges-9-seq-3, oranges-9-seq-4, oranges-9-seq-5, oranges-9-seq-6, oranges-9-seq-7, oranges-9-seq-8, oranges-9-seq-9
</plot>

<plot>
type = heatmap
file = /path/to/methylation3.bed
r1   = 0.77r
r0   = 0.69r
extend_bin = no
color = oranges-9-seq-1, oranges-9-seq-2, oranges-9-seq-3, oranges-9-seq-4, oranges-9-seq-5, oranges-9-seq-6, oranges-9-seq-7, oranges-9-seq-8, oranges-9-seq-9
</plot>

<plot>
type = heatmap
file = /path/to/te_density.bed
r1   = 0.66r
r0   = 0.58r
extend_bin = no
color = blues-9-seq-1, blues-9-seq-2, blues-9-seq-3, blues-9-seq-4, blues-9-seq-5, blues-9-seq-6, blues-9-seq-7, blues-9-seq-8, blues-9-seq-9
scale_log_base = 2
</plot>

<plot>
type = heatmap
file = /path/to/gene_density.bed
r1   = 0.55r
r0   = 0.47r
extend_bin = no
color = greens-9-seq-1, greens-9-seq-2, greens-9-seq-3, greens-9-seq-4, greens-9-seq-5, greens-9-seq-6, greens-9-seq-7, greens-9-seq-8, greens-9-seq-9
scale_log_base = 0.5
</plot>


</plots>

################################################################
# The remaining content is standard and required. It is imported 
# from default files in the Circos distribution.
#
# These should be present in every Circos configuration file and
# overridden as required. To see the content of these files, 
# look in etc/ in the Circos distribution.

<image>
# Included from Circos distribution.
<<include etc/image.conf>>
</image>

# RGB/HSV color definitions, color lists, location of fonts, fill patterns.
# Included from Circos distribution.
<<include etc/colors_fonts_patterns.conf>>

# Debugging, I/O an dother system parameters
# Included from Circos distribution.
<<include etc/housekeeping.conf>>
```

---

## **Run circos**

```bash
circos -conf circos.conf
```