# TestForTesseractOCR
测试使用TesseractOCR  
###遇到的问题###
- iOS Please make sure the TESSDATA_PREFIX environment variable is set to the parent directory of your "tessdata" directory.  
解决方法，build phases - copy bundle resources,选择tessdata(语言包,<https://sourceforge.net/projects/tesseract-ocr-alt/files/>或<https://github.com/tesseract-ocr/tessdata>)，选择folder conference。  
- read_params_file: parameter not found: allow_blob_division，  
解决方法，可以从下载一下链接中的语言包<https://sourceforge.net/projects/tesseract-ocr-alt/files/>
