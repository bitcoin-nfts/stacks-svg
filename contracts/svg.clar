(define-data-var nextTokenId uint u1)
(define-map Tokens uint (list 16 {i: uint, c: (optional (string-ascii 6))}))

(define-data-var nextPartId uint u1)
(define-map Parts uint (string-ascii 2000))

;; return number of avaliable parts
(define-read-only (parts-count) (- (var-get nextPartId) u1))

(define-read-only (get-img (id uint))
  (match (map-get? Tokens id) parts (some (generate parts)) none)
)

(define-private (generate (parts (list 16 {i: uint, c: (optional (string-ascii 6))})))
  (let ((cnt (len parts))) 
      (concat
        (concat
          (concat
            (concat (concat "" (if (< cnt u1) "" (get-part (element-at parts u0)))) (concat "" (if (< cnt u2) "" (get-part (element-at parts u1)))))
            (concat (concat "" (if (< cnt u3) "" (get-part (element-at parts u2)))) (concat "" (if (< cnt u4) "" (get-part (element-at parts u3)))))
          )
          (concat
            (concat (concat "" (if (< cnt u5) "" (get-part (element-at parts u4)))) (concat "" (if (< cnt u6) "" (get-part (element-at parts u5)))))
            (concat (concat "" (if (< cnt u7) "" (get-part (element-at parts u6)))) (concat "" (if (< cnt u8) "" (get-part (element-at parts u7)))))
          )
        )
        (concat
          (concat
            (concat (concat "" (if (< cnt u9) "" (get-part (element-at parts u8)))) (concat "" (if (< cnt u10) "" (get-part (element-at parts u9)))))
            (concat (concat "" (if (< cnt u11) "" (get-part (element-at parts u10)))) (concat "" (if (< cnt u12) "" (get-part (element-at parts u11)))))
          )
          (concat
            (concat (concat "" (if (< cnt u13) "" (get-part (element-at parts u12)))) (concat "" (if (< cnt u14) "" (get-part (element-at parts u13)))))
            (concat (concat "" (if (< cnt u15) "" (get-part (element-at parts u14)))) (concat "" (if (< cnt u16) "" (get-part (element-at parts u15)))))
          )
        )
      )
  )
)

(define-private (get-part (p (optional {i: uint, c: (optional (string-ascii 6))})))
  (match p pt
    (concat (concat (concat "<path fill='#" (default-to "aabbaa" (get c pt))) (concat "'d='" (unwrap-panic (map-get? Parts (get i pt))))) "'/>")
    ""
  )
)

;; insert new part
(define-private (add-part (p (string-ascii 2000)) (i uint)) (begin (map-insert Parts i p) (+ i u1)))

;; init
;; load base layers
(var-set nextPartId (fold add-part (contract-call? .parts get-parts) (var-get nextPartId)))
;; generate first token
(map-insert Tokens u1 (list 
  {i: u1, c: (some "00ff00")}
  {i: u2, c: (some "00ff00")}
  {i: u3, c: (some "00ff00")}
  {i: u4, c: (some "00ff00")}
  {i: u5, c: (some "00ff00")}
  {i: u6, c: (some "00ff00")}
  {i: u7, c: (some "00ff00")}
  {i: u8, c: (some "00ff00")}
  {i: u9, c: (some "00ff00")}
  {i: u10, c: (some "00ff00")}
  {i: u11, c: (some "00ff00")}
  {i: u12, c: (some "00ff00")}
  {i: u13, c: (some "00ff00")}
  {i: u14, c: (some "00ff00")}
  {i: u15, c: (some "00ff00")}
  {i: u16, c: (some "00ff00")}
))
(var-set nextTokenId u2)
