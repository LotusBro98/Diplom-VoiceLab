
# Pdflatex
PDFLATEX='pdflatex -interaction=nonstopmode -shell-escape -file-line-error'

# Файлы/Папки
PDF_NAME='diploma.pdf'
TEX='tex'
IMG='tex/figures'
MAINTEX='0-main'

# Конвертация eps
find $IMG/ -type f -name "*.eps" -exec epstopdf {} ";" ;
find $IMG -type f -name "*.eps" -exec rm -f {} \;

# Сборка latex
cd tex
$PDFLATEX $MAINTEX > /dev/null
BIBOUTPUT=$(bibtex $MAINTEX)
# Показывать output bibtex'a только в случае ошибок
if [[ "$BIBOUTPUT" =~ "error" ]]; then
    echo "$BIBOUTPUT"
fi
$PDFLATEX $MAINTEX > /dev/null
$PDFLATEX $MAINTEX

cp $MAINTEX.pdf ../$PDF_NAME
cd ..

# Clear
find $TEX/ -maxdepth 2 -type f -regex ".*\.\(log\|aux\|bbl\|blg\|out\|toc\|pdf\|in\|lua\|md\.tex\)" -exec rm -f {} \; ;


