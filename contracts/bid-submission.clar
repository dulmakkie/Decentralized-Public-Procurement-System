;; Bid Submission Contract
;; Manages contractor proposals for government projects

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-PROJECT-NOT-FOUND (err u101))
(define-constant ERR-BID-EXISTS (err u102))
(define-constant ERR-DEADLINE-PASSED (err u103))
(define-constant ERR-INVALID-AMOUNT (err u104))
(define-constant ERR-BID-NOT-FOUND (err u105))

;; Data Variables
(define-data-var next-project-id uint u1)
(define-data-var next-bid-id uint u1)

;; Data Maps
(define-map projects uint {
    title: (string-ascii 100),
    description: (string-ascii 500),
    budget: uint,
    deadline: uint,
    status: (string-ascii 20),
    creator: principal
})

(define-map bids uint {
    project-id: uint,
    vendor: principal,
    amount: uint,
    timeline: uint,
    proposal: (string-ascii 1000),
    submitted-at: uint
})

(define-map project-bids {project-id: uint, vendor: principal} uint)

;; Public Functions

;; Create a new procurement project
(define-public (create-project (title (string-ascii 100)) (description (string-ascii 500)) (budget uint) (deadline uint))
    (let ((project-id (var-get next-project-id)))
        (asserts! (> deadline block-height) ERR-DEADLINE-PASSED)
        (asserts! (> budget u0) ERR-INVALID-AMOUNT)
        (map-set projects project-id {
            title: title,
            description: description,
            budget: budget,
            deadline: deadline,
            status: "open",
            creator: tx-sender
        })
        (var-set next-project-id (+ project-id u1))
        (ok project-id)
    )
)

;; Submit a bid for a project
(define-public (submit-bid (project-id uint) (amount uint) (timeline uint) (proposal (string-ascii 1000)))
    (let (
        (project (unwrap! (map-get? projects project-id) ERR-PROJECT-NOT-FOUND))
        (bid-id (var-get next-bid-id))
    )
        (asserts! (< block-height (get deadline project)) ERR-DEADLINE-PASSED)
        (asserts! (> amount u0) ERR-INVALID-AMOUNT)
        (asserts! (<= amount (get budget project)) ERR-INVALID-AMOUNT)
        (asserts! (is-none (map-get? project-bids {project-id: project-id, vendor: tx-sender})) ERR-BID-EXISTS)

        (map-set bids bid-id {
            project-id: project-id,
            vendor: tx-sender,
            amount: amount,
            timeline: timeline,
            proposal: proposal,
            submitted-at: block-height
        })
        (map-set project-bids {project-id: project-id, vendor: tx-sender} bid-id)
        (var-set next-bid-id (+ bid-id u1))
        (ok bid-id)
    )
)

;; Update project status (admin only)
(define-public (update-project-status (project-id uint) (new-status (string-ascii 20)))
    (let ((project (unwrap! (map-get? projects project-id) ERR-PROJECT-NOT-FOUND)))
        (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
        (map-set projects project-id (merge project {status: new-status}))
        (ok true)
    )
)

;; Read-only Functions

;; Get project details
(define-read-only (get-project (project-id uint))
    (map-get? projects project-id)
)

;; Get bid details
(define-read-only (get-bid (bid-id uint))
    (map-get? bids bid-id)
)

;; Get bid by project and vendor
(define-read-only (get-vendor-bid (project-id uint) (vendor principal))
    (match (map-get? project-bids {project-id: project-id, vendor: vendor})
        bid-id (map-get? bids bid-id)
        none
    )
)

;; Check if bidding is still open
(define-read-only (is-bidding-open (project-id uint))
    (match (map-get? projects project-id)
        project (< block-height (get deadline project))
        false
    )
)

;; Get current project ID counter
(define-read-only (get-next-project-id)
    (var-get next-project-id)
)

;; Get current bid ID counter
(define-read-only (get-next-bid-id)
    (var-get next-bid-id)
)
