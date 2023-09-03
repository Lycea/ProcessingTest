;; Load the publishing system
(require 'ox-publish)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "my-org-site"
             :recursive t
             :base-directory "./raw_posts"
             :publishing-directory "./posts"
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
{{TEMPLATE:content/base_header}}
<div class=\"main\"> <!-- start main div -->
<div class=\"content\">
"
             :html-postamble "
</div> <!-- content div end -->
{{TEMPLATE:content/base_side}}
</div> <!-- end main div -->

{{TEMPLATE:content/base_footer}}
"
             ;;postable: set html content after the content
             )))

(setq org-export-with-title t)
(setq org-html-validation-link nil)
;; Generate the site output
(org-publish-all t)
;;(org-export-data )





(message "Build complete!")
