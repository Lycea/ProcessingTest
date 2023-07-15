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
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil
             )))

;; Generate the site output
(org-publish-all t)




(message "Build complete!")
