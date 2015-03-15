#!/usr/bin/env roseus

(require "package://euslisp/jskeus/irteus/demo/sample-robot-model.l")

(defvar *robot* (instance sample-robot :init))

;; random init
(defvar *random-seed* (integer-vector (cadr (unix:gettimeofday)) 10))
(random 1.0 *random-seed*)
;; (print (random 1.0 *random-seed*)) (exit)
;; (defun random-test
;;   nil
;;   (let* ((seed (cadr (unix:gettimeofday))))
;;     (format t "~A -> ~A~%" seed (random 1.0 (integer-vector seed 10)))))


(send *robot* :reset-pose)
(send *robot* :fix-leg-to-coords (make-coords))
(objects (list *robot*))

(send *irtviewer* :change-background #f(1 1 1))
(send *viewer* :draw-objects)

(defun gen-random-image
  (path)
  (mapcar
   #'(lambda (j)
       (send j :joint-angle (+ (* (random 1.0 *random-seed*)
				  (- (send j :max-angle)
				     (send j :min-angle)))
			       (send j :min-angle))))
   (send *robot* :joint-list))
  (send *viewer* :draw-objects)
  (send *viewer* :viewsurface :write-to-image-file path)
  )
