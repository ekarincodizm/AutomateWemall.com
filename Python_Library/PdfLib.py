from tempfile import TemporaryFile
import subprocess
from os.path import abspath, dirname, join
import os
from robot.api import logger


THIS_DIR = dirname(abspath(__file__))
PDFTOTEXT = join(THIS_DIR, 'xpdf', 'pdftotext.exe')


class PdfLibraryPOC(object):

    def convert_pdf_to_text_using_pdftotext(self, path, *arguments):
        """Converts a PDF to text using an external tool.
        
        Examples:
        | # get all text         |                                     |                          |    |   |    |   |
        | ${content}=            | Convert Pdf To Text Using Pdftotext | ${OUTPUT_DIR}${/}foo.pdf |    |   |    |   |
        | # get text of 2nd page |                                     |                          |    |   |    |   |
        | ${content}=            | Convert Pdf To Text Using Pdftotext | ${OUTPUT_DIR}${/}bar.pdf | -f | 2 | -l | 2 |

        Optional arguments:
        | -f <int>          | first page to convert                                       |
        | -l <int>          | last page to convert                                        |
        | -layout           | maintain original physical layout                           |
        | -fixed <fp>       | assume fixed-pitch (or tabular) text                        |
        | -raw              | keep strings in content stream order                        |
        | -htmlmeta         | generate a simple HTML file, including the meta information |
        | -enc <string>     | output text encoding name                                   |
        | -eol <string>     | output end-of-line convention (unix, dos, or mac)           |
        | -nopgbrk          | don't insert page breaks between pages                      |
        | -opw <string>     | owner password (for encrypted files)                        |
        | -upw <string>     | user password (for encrypted files)                         |
        | -q                | don't print any messages or errors                          |
        | -cfg <string>     | configuration file to use in place of .xpdfrc               |
        """
        txt_file = TemporaryFile(delete=False)
        try:
            txt_file.close()
            args = [PDFTOTEXT] + list(arguments) + [path, txt_file.name]
            logger.debug("Executing:\n" + " ".join(args))
            output = subprocess.check_output(args)
            logger.debug(output)
            with open (txt_file.name, "r") as out_file:
                content = out_file.read()
        finally:
            os.remove(txt_file.name)
        return content


if __name__ == '__main__':
    lib = PdfLibraryFTD()
    path = raw_input("Enter path to PDF: ")
    content = lib.convert_pdf_to_text_using_pdftotext(path, ['-f', '2','-l', '2'])
    print content
