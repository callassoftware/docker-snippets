#!/bin/bash

rm -r -f doc var
mkdir -p var/PDFAExtSchema
pushd etc
rm -r -f HtmlConverter  OCRTool  PDFOfficeTool  PDFPSTool
popd

