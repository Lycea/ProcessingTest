;;install htmlize for codeblocks
;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)
(require 'simple)

(message "generate full posts")


;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./raw_posts"
             :publishing-directory "./.org_gen/posts"
             :publishing-function 'org-html-publish-to-html
             :with-author nil;; Don't include author name
             :with-creator nil            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :with-date nil
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil

             :html-head-include-scripts nil
             :html-head-include-default-style nil

             :html-head "<link rel=\"stylesheet\" href=\"../../style.css\"/>"
             
             ;;preamble : used for setting html before the post
             :html-preamble "
{{TEMPLATE:content/base_header.html}}
<div class=\"main\"> <!-- start main div -->
<div class=\"content\">
"
             :html-postamble "
</div> <!-- content div end -->
{{TEMPLATE:content/base_side.html}}
</div> <!-- end main div -->

{{TEMPLATE:content/base_footer.html}}
"
             ;;postable: set html content after the content
             )))

(setq org-export-with-title t)
(setq org-html-validation-link nil)
;; Generate the site output
(org-publish-all t)
;;(org-export-data )
;;---------------------
;; no pre / post ables
;;


(message "-------------------------")
(message "Build raw no header posts")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./raw_posts"
             :publishing-directory "./.org_gen/posts-pure"
             :publishing-function 'org-html-publish-to-html
             :with-author nil;; Don't include author name
             :with-creator nil            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :with-date nil
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil

             :html-head-include-scripts nil
             :html-head-include-default-style nil

             :html-head "<link rel=\"stylesheet\" href=\"../../style.css\"/>"

             )))

(setq org-export-with-title t)
(setq org-html-validation-link nil)
;; Generate the site output
(org-publish-all t)


;;------------------------------
;; PARSE PAGES
;; Define the publishing project

(message "----------------------------")
(message "Start generating other pages")



(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./pages"
             :publishing-directory "./.org_gen/pages"
             :publishing-function 'org-html-publish-to-html
             :with-author nil;; Don't include author name
             :with-creator nil            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :with-date nil
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil

             :html-head-include-scripts nil
             :html-head-include-default-style nil

             :html-head "{{TEMPLATE: content/standard_head.html}}"
             :html-container nil
            ;;postable: set html content after the content
             )))

(setq org-export-with-title t)
(setq org-html-validation-link nil)

(defun my-org-html-postprocess (html)
  "Post-process the HTML to remove unwanted outline containers."
  (message "post processing ?")
  (replace-regexp-in-string "<div class=\"section.*?\">\\(.*?\\)</div>" "\\1" html))

(setq org-html-post-process-hook '(my-org-html-postprocess))

;; Generate the site output
(org-publish-all t)






(message "Build complete!")
