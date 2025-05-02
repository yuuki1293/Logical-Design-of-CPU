# ファイル名設定
DOCXFILE = cover.docx
COVERPDF = cover.pdf
TEXFILE = main
OUTPUT = final_output.pdf
OUTDIR = build

.PHONY: all clean

# 全体ターゲット
all: $(OUTPUT)

# Word表紙をPDFに変換（LibreOffice）
$(OUTDIR)/$(COVERPDF): $(DOCXFILE)
	soffice --headless --convert-to pdf "$<" --outdir $(OUTDIR)

# LaTeX本文PDF生成
$(OUTDIR)/$(TEXFILE).pdf: $(TEXFILE).tex
	pdflatex -output-directory $(OUTDIR) $(TEXFILE)

# 表紙と本文を結合
$(OUTPUT): $(OUTDIR)/$(COVERPDF) $(OUTDIR)/$(TEXFILE).pdf
	pdfunite $(OUTDIR)/$(COVERPDF) $(OUTDIR)/$(TEXFILE).pdf $(OUTPUT)

# クリーン
clean:
	rm -rf $(OUTDIR) $(OUTPUT)
