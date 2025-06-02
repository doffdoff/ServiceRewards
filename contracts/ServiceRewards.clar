;; ServiceRewards: Community Volunteer Tracking System
;; Version: 1.0.0

(define-data-var community-coordinator principal tx-sender)
(define-data-var service-pool uint u0)
(define-data-var volunteer-bonus uint u110) ;; bonus points added per block
(define-data-var bonus-timestamp uint u0) ;; last block when bonuses were calculated
(define-map volunteer-contributions principal uint)

;; Helper function to ensure only the community coordinator can perform certain actions
(define-private (is-coordinator (caller principal))
  (begin
    (asserts! (is-eq caller (var-get community-coordinator)) (err u500))
    (ok true)))

;; Initialize the volunteer system
(define-public (establish-community (coordinator principal))
  (begin
    (asserts! (is-none (map-get? volunteer-contributions coordinator)) (err u501))
    (var-set community-coordinator coordinator)
    (ok "ServiceRewards community established")))

;; Add volunteer hours to the system
(define-public (log-service-hours (hours uint))
  (begin
    (asserts! (> hours u0) (err u502))
    (let ((current-contributions (default-to u0 (map-get? volunteer-contributions tx-sender))))
      (map-set volunteer-contributions tx-sender (+ current-contributions hours))
      (var-set service-pool (+ (var-get service-pool) hours))
      (ok (+ current-contributions hours)))))

;; Calculate volunteer bonuses for all community members
(define-public (distribute-volunteer-bonuses)
  (begin
    (try! (is-coordinator tx-sender))
    (let ((current-block tenure-height)
          (previous-update (var-get bonus-timestamp)))
      (asserts! (> current-block previous-update) (err u503))
      ;; Calculate bonuses based on blocks elapsed
      (let ((elapsed (- current-block previous-update))
            (total-bonus (* elapsed (var-get volunteer-bonus))))
        (var-set bonus-timestamp current-block)
        (var-set service-pool (+ (var-get service-pool) total-bonus))
        (ok total-bonus)))))

;; Claim volunteer contributions and bonuses
(define-public (claim-service-rewards)
  (begin
    (let ((volunteer-achievement (default-to u0 (map-get? volunteer-contributions tx-sender))))
      (asserts! (> volunteer-achievement u0) (err u504))
      (let ((total-contributions (var-get service-pool))
            (total-bonus (* (var-get volunteer-bonus) (- tenure-height (var-get bonus-timestamp))))
            (proportion (/ (* volunteer-achievement u100000) total-contributions)))
        ;; Update contributions and calculate bonus proportion
        (let ((bonus-portion (/ (* proportion total-bonus) u100000)))
          (map-delete volunteer-contributions tx-sender)
          (var-set service-pool (- (var-get service-pool) volunteer-achievement))
          (ok (+ volunteer-achievement bonus-portion)))))))