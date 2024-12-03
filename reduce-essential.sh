#!/bin/bash

# inspired by https://help.callassoftware.com/m/pdftoolbox/l/793898-file-components-and-their-use-in-pdftoolbox-sdk
rm -r -f doc var
mkdir -p var/PDFAExtSchema
pushd etc
rm -r -f HtmlConverter  OCRTool  PDFOfficeTool  PDFPSTool
popd

