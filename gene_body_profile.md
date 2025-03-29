# **Generating Gene Methylation Profiles Using deepTools**

---

## **Step 1: Convert bedGraph to BigWig**
The **bedGraphToBigWig** tool converts methylation bedGraph files into BigWig format for visualization.

### **Command Syntax**
```bash
bedGraphToBigWig <input.bedGraph> <chrom.sizes> <output.bw>
```

---

## **Step 2: Compute Matrix for Methylation Signal**
The **computeMatrix** tool generates a matrix of methylation signal across genomic regions.

### **Command Syntax**
```bash
computeMatrix scale-regions \
    -S <BigWig_files> \
    -R <BED_file> \
    -b 2000 -a 2000 -m 4000 \
    -out <Output_file> \
    -p <Threads>
```

---

## **Step 3: Plot Methylation Profile**
The **plotProfile** tool visualizes the methylation pattern across genomic regions.

### **Command Syntax**
```bash
plotProfile -m <Input_matrix> -o <Output_image> --samplesLabel <Labels> --perGroup --colors <Color_codes>
```

---

## **Fix: Adjusting Line Thickness in deepTools**
By default, **deepTools plot lines may be too thick and overlap**. To fix this:
1. Locate the file **`heatmapper_utilities.py`**  
2. Edit **line 71**:
   - **Original:**  
     ```python
     ax.plot(x, summary, color=color, label=label, alpha=0.9)
     ```
   - **Modified (Thinner Line Width):**  
     ```python
     ax.plot(x, summary, color=color, label=label, alpha=0.9, linewidth=0.4)
     ```