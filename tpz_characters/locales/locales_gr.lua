local locales = { -- <- DO NOT TOUCH, MOVE TO LAST SECTION FOR LOCALE CHECK.
    ['NUI_TITLE']                                      = "ΔΗΜΙΟΥΡΓΙΑ ΧΑΡΑΚΤΗΡΑ",
    ['NUI_MAIN_PAGE_WELCOME']                          = "Καλώς ήλθατε στο Daisy Town Roleplay.\n\nΚύριε/Κυρία %s.\n\nΑρχίστε το ταξίδι σας διαμορφώνοντας έναν μοναδικό χαρακτήρα. Επιλέξτε όνομα, ύφος και υπόβαθρο για να ζωντανέψετε την ιστορία σας.", -- %s returns player first and last name.
    ['NUI_CLOSE']                                      = "Έξοδος",
    ['NUI_ACCEPT_OUTFIT']                              = "Δημιουργία Χαρακτήρα",
    ['NUI_OUTFITS']                                    = "Ένδυση",
    ['NUI_MAKEUP']                                     = "Μακιγιάζ",
    ['NUI_FACIALS']                                    = "Πρόσωπο",
    ['NUI_IDENTITY']                                   = "Πληροφορίες Ταυτότητας",
    ['NUI_APPEARANCE']                                 = "Εμφάνιση Χαρακτήρα",
    
    ['DIALOG_SEX_TITLE']                               = "ΕΠΙΛΕΞΤΕ ΤΟ ΦΥΛΟ ΤΟΥ ΝΕΟΥ ΣΑΣ ΧΑΡΑΚΤΗΡΑ",
    ['DIALOG_SEX_DESCRIPTION']                         = "Επιλέξτε το φύλο του χαρακτήρα σας. Αυτό θα καθορίσει τον βασικό τύπο σώματος και τις επιλογές εμφάνισης που θα μπορείτε να προσαρμόσετε αργότερα.",
    ['DIALOG_SEX_INPUT_DESCRIPTION']                   = "Παρακαλώ πληκτρολογήστε το φύλο σας παρακάτω, όπως: MALE ή FEMALE",
    ['DIALOG_SEX_SELECT_BUTTON']                       = "ΕΠΙΛΟΓΗ",
    ['INVALID_SEX_INPUT']                              = "Παρακαλώ επιλέξτε έγκυρο φύλο για τον χαρακτήρα σας.",
    
    ['DIALOG_TITLE']                                   = "ΤΡΟΠΟΠΟΙΗΣΤΕ ΤΙΣ ΠΛΗΡΟΦΟΡΙΕΣ ΤΑΥΤΟΤΗΤΑΣ ΤΟΥ ΧΑΡΑΚΤΗΡΑ",
    ['DIALOG_SAVE_BUTTON']                             = "ΑΠΟΘΗΚΕΥΣΗ ΤΑΥΤΟΤΗΤΑΣ",
    
    ['INVALID_DATE_OF_BIRTH']                          = "Παρακαλώ εισάγετε έγκυρη ημερομηνία γέννησης.",
    ['INVALID_FIRSTNAME_OR_LASTNAME']                  = "Παρακαλώ εισάγετε έγκυρο όνομα ή επώνυμο.",
    
    ['NUI_RESET_OUTFIT_TYPE']                          = "Επαναφορά Ενδύματος στην Προεπιλογή",
    ['NUI_SELECT_TINT']                                = "Φόρτωση Επιλεγμένων Αποχρώσεων",
    ['NUI_SELECT_COMPONENT']                           = "Επιλογή Στοιχείου",
    ['NUI_SELECT_PALETTE_TITLE']                       = "Επιλέξτε Παλέτα",
    ['NUI_SELECT_BUY']                                 = "Αγορασε Τώρα",
    ['NUI_SELECT_BOUGHT']                              = "Αγοράστηκε",
    ['NUI_SELECT_COST']                                = "Το κόστος για την αγορά του %s ανέρχεται σε ($%s) δολάρια ανά τεμάχιο.",
    
    -- AGEING SECTION
    ['NUI_AGEING_INFO']                                = "Προσαρμόστε την ηλικία του χαρακτήρα σας, ρυθμίζοντας την εμφάνιση από νεανική έως ώριμη.",
    ['NUI_AGEING_TEXTURE_ID']                          = "Επιλέξτε την ηλικία του χαρακτήρα σας.",
    ['NUI_AGEING_OPACITY']                             = "Επιλέξτε την αδιαφάνεια του αποτελέσματος ηλικίας του χαρακτήρα.",
    
    -- APPEARANCE SECTION
    ['NUI_APPEARANCE_INFO']                            = "Προσαρμόστε την εμφάνιση του χαρακτήρα σας σύμφωνα με τις προτιμήσεις σας.",
    ['NUI_APPEARANCE_BODY']                            = "Τύποι Σώματος",
    ['NUI_APPEARANCE_HERITAGE']                        = "Καταγωγή",
    ['NUI_APPEARANCE_GROOM']                           = "Κούρεμα / Περιποίηση",
    ['NUI_APPEARANCE_AGEING']                          = "Γήρανση",
    ['NUI_APPEARANCE_HEIGHT']                          = "Ρύθμιση Ύψους",
    ['NUI_APPEARANCE_EYES']                            = "Χρωματισμός Ματιών",
    ['NUI_APPEARANCE_BODY_FEATURES']                   = "Χαρακτηριστικά Σώματος",
    ['NUI_APPEARANCE_LIFESTYLE']                       = "Στυλ Ζωής",
    ['NUI_APPEARANCE_MAKEUP']                          = "Μακιγιάζ",
    
    -- APPEARANCE BODY SECTION
    ['NUI_BODY_INFO']                                  = "Ρυθμίστε μέση, κορμό και πόδια για σχήμα, μέγεθος και ορισμό και δημιουργήστε μια μοναδική φυσιογνωμία.",
    ['NUI_BODY_TYPES']                                 = "Τύποι Σώματος",
    ['NUI_WAIST_TYPES']                                = "Μέσες",
    ['NUI_TORSO_TYPES']                                = "Κορμός",
    ['NUI_LEGS_TYPES']                                 = "Πόδια",
    
    -- APPEARANCE HERITAGE SECTION
    
    ['NUI_HERITAGE_INFO']                              = "Ρυθμίστε τον τύπο κεφαλιού και τις αποχρώσεις δέρματος του προσώπου του χαρακτήρα σας.",
    ['NUI_HERITAGE_TYPES']                             = "Επιλέξτε τον τύπο χρώματος προσώπου του χαρακτήρα σας.",
    ['NUI_HERITAGE_COLORS']                            = "Επιλέξτε τον τόνο του προσώπου του χαρακτήρα σας.",
    
    -- APPEARANCE HAIR SECTION
    ['NUI_HAIR_BUTTON']                                = "Χτενίσματα",
    ['NUI_HAIR_BEARD_BUTTON']                          = "Τρίχες Προσώπου (Γένια)",
    ['NUI_HAIR_BEARD_STABBLE_BUTTON']                  = "Στυλ Ξυρού Γενειάδος",
    ['NUI_HAIR_EYEBROWS_BUTTON']                       = "Φρύδια",
    ['NUI_HAIR_OVERLAY_BUTTON']                        = "Ξυρισμένο",
    
    ['NUI_APPEARANCE_HEIGHT_TITLE']                    = "Ρύθμιση Ύψους",
    ['NUI_APPEARANCE_HEIGHT_DESCRIPTION']              = "Επιλέξτε την επιθυμητή ρύθμιση ύψους για τον νέο σας χαρακτήρα.",
    
    -- APPEARANCE LIFESTYLE SECTION
    ['NUI_LIFESTYLES_INFO']                            = "Προσαρμόστε τις λεπτομέρειες του δέρματος του χαρακτήρα σας με ρεαλιστικά χαρακτηριστικά.",
    ['NUI_LIFESTYLES_TEXTURE_TITLE']                   = "Επιλέξτε Υφή",
    ['NUI_LIFESTYLES_OPACITY_TITLE']                   = "Αδιαφάνεια - Ορατότητα",
    ['NUI_LIFESTYLES_MOLES']                           = 'Ελιές',
    ['NUI_LIFESTYLES_MOLES_INFO']                      = 'Μικρές, φυσικές κηλίδες στο δέρμα που προσδίδουν ατομικότητα και ρεαλισμό στον χαρακτήρα σας.',
    
    ['NUI_LIFESTYLES_SPOTS']                           = 'Κηλίδες',
    ['NUI_LIFESTYLES_SPOTS_INFO']                      = 'Μικρές ατέλειες ή σημάδια που υποδηλώνουν υφή και ατέλεια στο δέρμα.',
    
    ['NUI_LIFESTYLES_COMPLEX']                         = 'Τόνος Δέρματος',
    ['NUI_LIFESTYLES_COMPLEX_INFO']                    = 'Ρυθμίστε τον συνολικό τόνο, την υφή και τη διαύγεια του δέρματος για μια μοναδική εμφάνιση.',
    
    ['NUI_LIFESTYLES_ACNE']                            = 'Φαγεσωρικά',
    ['NUI_LIFESTYLES_ACNE_INFO']                       = 'Ορατές ακμές ή εξάρσεις που προσδίδουν μια νότα ρεαλισμού και νεότητας.',
    
    ['NUI_LIFESTYLES_FRECKLES']                        = 'Εφηλίδες',
    ['NUI_LIFESTYLES_FRECKLES_INFO']                   = 'Απαλά, διασκορπισμένα στίγματα που δίνουν μια ηλιακά φιλημένη ή γοητευτική εμφάνιση.',
    
    ['NUI_LIFESTYLES_DISCOLORATION']                   = 'Αποχρωματισμοί',
    ['NUI_LIFESTYLES_DISC_INFO']                       = 'Λεπτές διακυμάνσεις τόνου που αντικατοπτρίζουν φυσική ποικιλία δέρματος ή γήρανση.',
    
    ['NUI_LIFESTYLES_SCARS']                           = 'Ουλές',
    ['NUI_LIFESTYLES_SCARS_INFO']                      = 'Επούλωση τραυμάτων ή γρατζουνιές που αφηγούνται ιστορίες παλαιότερων εμπειριών.',
    
    ['NUI_LIFESTYLES_GRIME']                           = 'Βρωμιά',
    ['NUI_LIFESTYLES_GRIME_INFO']                      = 'Λεκέδες, μουτζούρες ή λεκέδες που προσδίδουν μια τραχιά, βιογραφική αίσθηση στον χαρακτήρα.',
    
    -- APPEARANCE BODY FEATURES SECTION
    ['NUI_BODYFEATURES_INFO']                          = "Ρυθμίστε χαρακτηριστικά για ένα μοναδικό πρόσωπο και σώμα που ταιριάζει στην οραματισμένη σας εικόνα.",
    
    ['NUI_BODY_FEATURES_TEETH']                        = 'Δόντια',
    ['NUI_BODY_FEATURES_TEETH_INFO']                   = 'Μορφοποιήστε το χαμόγελο του χαρακτήρα σας με διαφορετικά στυλ και λεπτομέρειες δοντιών.',
    
    ['NUI_BODY_FEATURES_JAW']                          = 'Σιαγόνα',
    ['NUI_BODY_FEATURES_JAW_INFO']                     = 'Ρυθμίστε το πλάτος και τη δομή για να ορίσετε το προφίλ του προσώπου του χαρακτήρα.',
    
    ['NUI_BODY_FEATURES_CHIN']                         = 'Πηγούνι',
    ['NUI_BODY_FEATURES_CHIN_INFO']                    = 'Εξευγενίστε το μέγεθος και το σχήμα του πηγουνιού για μια ισορροπημένη ή τολμηρή εμφάνιση.',
    
    ['NUI_BODY_FEATURES_HEAD']                         = 'Κεφάλι',
    ['NUI_BODY_FEATURES_HEAD_INFO']                    = 'Επιλέξτε το συνολικό σχήμα, το μέγεθος και τις αναλογίες του κεφαλιού για να καθορίσετε τη βάση του χαρακτήρα.',
    
    ['NUI_BODY_FEATURES_NOSE']                         = 'Μύτη',
    ['NUI_BODY_FEATURES_NOSE_INFO']                    = 'Προσαρμόστε το μήκος, το πλάτος και τη γέφυρα για μια χαρακτηριστική έκφραση προσώπου.',
    
    ['NUI_BODY_FEATURES_EARS']                         = 'Αυτιά',
    ['NUI_BODY_FEATURES_EARS_INFO']                    = 'Τροποποιήστε το μέγεθος, τη γωνία και το στυλ για να ταιριάξετε την προσωπικότητα του χαρακτήρα.',
    
    ['NUI_BODY_FEATURES_MOUTHANDLIPS']                 = 'Στόμα & Χείλη',
    ['NUI_BODY_FEATURES_MOUTHANDLIPS_INFO']            = 'Ρυθμίστε την πληρότητα, την καμπυλότητα και την έκφραση για να διαμορφώσετε το ιδανικό χαμόγελο ή μειδίαμα.',
    
    ['NUI_BODY_FEATURES_CHEEK']                        = 'Ζυγωματικά',
    ['NUI_BODY_FEATURES_CHEEK_INFO']                   = 'Λεπτομερείς ρυθμίσεις ύψους και ορισμού ζυγωματικών για διακριτές ή έντονες γωνίες.',
    
    ['NUI_BODY_FEATURES_EYESANDBROWS']                 = 'Μάτια & Φρύδια',
    ['NUI_BODY_FEATURES_EYESANDBROWS_INFO']            = 'Ορίστε το σχήμα, το χρώμα των ματιών και το στυλ των φρυδιών για να δώσετε μοναδικό συναίσθημα και βάθος στον χαρακτήρα.',
    
    ['NUI_BODY_FEATURES_UPPERBODY']                    = 'Άνω Σώμα',
    ['NUI_BODY_FEATURES_UPPERBODY_INFO']               = 'Σχηματίστε κορμό, ώμους και χέρια για να δημιουργήσετε την επιθυμητή σωματοδομή και στάση.',
    
    ['NUI_BODY_FEATURES_LOWERBODY']                    = 'Κάτω Σώμα',
    ['NUI_BODY_FEATURES_LOWERBODY_INFO']               = 'Ρυθμίστε μέση, γοφούς και πόδια για να ολοκληρώσετε τη φυσιογνωμία του χαρακτήρα.',
    
    -- APPEARANCE GROOM SECTION
    ['NUI_GROOM_INFO']                                 = "Ένα λεπτομερές σύστημα μαλλιών και γενειάδας σχεδιασμένο να προσφέρει φυσική ροή, υφή και έκφραση στον χαρακτήρα.",
    
    ['NUI_GROOM_HAIR']                                 = "Μαλλιά",
    ['NUI_GROOM_HAIR_INFO']                            = "Προσαρμόστε το κούρεμα και το χρώμα μαλλιών του χαρακτήρα σας με ρυθμιζόμενο μήκος, υφή και ανταύγειες.",
    ['NUI_GROOM_HAIR_DESC']                            = "Μαλλιά",
    ['NUI_GROOM_HAIR_COLORS']                          = "Χρώματα Στοιχείου",
    ['NUI_GROOM_HAIR_OPACITY']                         = "Αδιαφάνεια",
    
    ['NUI_GROOM_OVERLAY']                              = "Επικαλύψεις Μαλλιών",
    ['NUI_GROOM_OVERLAY_INFO']                         = "Επικαλύψεις Μαλλιών",
    ['NUI_GROOM_OVERLAY_DESC']                         = "Επικαλύψεις Μαλλιών",
    ['NUI_GROOM_OVERLAY_COLORS']                       = "Χρώματα Στοιχείου",
    ['NUI_GROOM_OVERLAY_OPACITY']                      = "Αδιαφάνεια",
    
    ['NUI_GROOM_BEARD']                                = "Γένια",
    ['NUI_GROOM_BEARD_INFO']                           = "Επιλέξτε από διάφορα στυλ και μήκη. Ελέγξτε την πυκνότητα και το χρώμα για πιο λεπτομερή εμφάνιση.",
    ['NUI_GROOM_BEARD_DESC']                           = "Γένια",
    ['NUI_GROOM_BEARD_COLORS']                         = "Χρώματα Στοιχείου",
    ['NUI_GROOM_BEARD_OPACITY']                        = "Αδιαφάνεια",
    
    ['NUI_GROOM_BEARDSTABBLE']                         = "Ξυρισμένη Γενειάδα",
    ['NUI_GROOM_BEARDSTABBLE_INFO']                    = "Ξυρισμένη Γενειάδα",
    ['NUI_GROOM_BEARDSTABBLE_DESC']                    = "Ξυρισμένη Γενειάδα",
    ['NUI_GROOM_BEARDSTABBLE_COLORS']                  = "Χρώματα Στοιχείου",
    ['NUI_GROOM_BEARDSTABBLE_OPACITY']                 = "Αδιαφάνεια",
    
    ['NUI_GROOM_BOW']                                  = "Φιόγκος",
    ['NUI_GROOM_BOW_INFO']                             = "Φιόγκος",
    ['NUI_GROOM_BOW_INFO_DESC']                        = "Φιόγκος",
    ['NUI_GROOM_BOW_INFO_COLORS']                      = "Χρώματα Στοιχείου",
    ['NUI_GROOM_BOW_INFO_OPACITY']                     = "Αδιαφάνεια",
    
    ['NUI_GROOM_EYEBROWS']                             = "Φρύδια",
    ['NUI_GROOM_EYEBROWS_INFO']                        = "Επεξεργαστείτε το σχήμα, το μέγεθος και το χρώμα των φρυδιών ώστε να ταιριάζουν στο πρόσωπο του χαρακτήρα.",
    ['NUI_GROOM_EYEBROWS_DESC']                        = "Φρύδια",
    ['NUI_GROOM_EYEBROWS_COLORS']                      = "Χρώματα Στοιχείου",
    ['NUI_GROOM_EYEBROWS_OPACITY']                     = "Αδιαφάνεια",
    
    -- APPEARANCE MAKEUP SECTION
    ['NUI_MAKEUP_INFO']                                = "Προσαρμόστε το μακιγιάζ του χαρακτήρα σας — foundation, κραγιόν, σκιές, μολύβια ματιών και ρουζ.",
    
    ['NUI_MAKEUP_FOUNDATION']                          = 'Foundation',
    ['NUI_MAKEUP_FOUNDATION_DESC']                     = 'Εξομαλύνει και ομογενοποιεί τον τόνο του δέρματος, δημιουργώντας μια άψογη βάση για το μακιγιάζ.',
    ['NUI_MAKEUP_FOUNDATION_TEXTURE']                  = 'Τύποι Υφής',
    ['NUI_MAKEUP_FOUNDATION_PRIMARY_COLOR']            = 'Κύριο Χρώμα',
    ['NUI_MAKEUP_FOUNDATION_SECONDARY_COLOR']          = 'Δευτερεύον Χρώμα',
    ['NUI_MAKEUP_FOUNDATION_VARIANT']                  = 'Παραλλαγές',
    ['NUI_MAKEUP_FOUNDATION_OPACITY']                  = 'Αδιαφάνεια',
    
    ['NUI_MAKEUP_LIPSTICKS']                           = 'Κραγιόν',
    ['NUI_MAKEUP_LIPSTICKS_DESC']                      = 'Προσθέτει έντονο χρώμα και ορισμό στα χείλη, ενισχύοντας τη φυσική ομορφιά.',
    ['NUI_MAKEUP_LIPSTICKS_TEXTURE']                   = 'Τύποι Υφής',
    ['NUI_MAKEUP_LIPSTICKS_PRIMARY_COLOR']             = 'Κύριο Χρώμα',
    ['NUI_MAKEUP_LIPSTICKS_SECONDARY_COLOR']           = 'Δευτερεύον Χρώμα',
    ['NUI_MAKEUP_LIPSTICKS_VARIANT']                   = 'Παραλλαγές',
    ['NUI_MAKEUP_LIPSTICKS_OPACITY']                   = 'Αδιαφάνεια',
    
    
    ['NUI_MAKEUP_SHADOWS']                             = 'Σκιές',
    ['NUI_MAKEUP_SHADOWS_DESC']                        = 'Προσδίδει χρώμα και βάθος στα μάτια, ιδανικό για απαλή ή έντονη εμφάνιση.',
    ['NUI_MAKEUP_SHADOWS_TEXTURE']                     = 'Τύποι Υφής',
    ['NUI_MAKEUP_SHADOWS_PRIMARY_COLOR']               = 'Κύριο Χρώμα',
    ['NUI_MAKEUP_SHADOWS_SECONDARY_COLOR']             = 'Δευτερεύον Χρώμα',
    ['NUI_MAKEUP_SHADOWS_VARIANT']                     = 'Παραλλαγές',
    ['NUI_MAKEUP_SHADOWS_OPACITY']                     = 'Αδιαφάνεια',
    
    ['NUI_MAKEUP_EYELINERS']                           = 'Μολύβια Ματιών',
    ['NUI_MAKEUP_EYELINERS_DESC']                      = 'Ορίζει και τονίζει τα μάτια, προσδίδοντας αιχμηρή ή διακριτική έμφαση.',
    ['NUI_MAKEUP_EYELINERS_TEXTURE']                   = 'Τύποι Υφής',
    ['NUI_MAKEUP_EYELINERS_PRIMARY_COLOR']             = 'Κύριο Χρώμα',
    ['NUI_MAKEUP_EYELINERS_SECONDARY_COLOR']           = 'Δευτερεύον Χρώμα',
    ['NUI_MAKEUP_EYELINERS_VARIANT']                   = 'Παραλλαγές',
    ['NUI_MAKEUP_EYELINERS_OPACITY']                   = 'Αδιαφάνεια',
    
    ['NUI_MAKEUP_BLUSH']                               = 'Ρουζ',
    ['NUI_MAKEUP_BLUSH_DESC']                          = 'Προσθέτει μια φρέσκια, λαμπερή απόχρωση στα μάγουλα για υγιή, λαμπερό τελείωμα.',
    ['NUI_MAKEUP_BLUSH_TEXTURE']                       = 'Τύποι Υφής',
    ['NUI_MAKEUP_BLUSH_PRIMARY_COLOR']                 = 'Κύριο Χρώμα',
    ['NUI_MAKEUP_BLUSH_SECONDARY_COLOR']               = 'Δευτερεύον Χρώμα',
    ['NUI_MAKEUP_BLUSH_VARIANT']                       = 'Παραλλαγές',
    ['NUI_MAKEUP_BLUSH_OPACITY']                       = 'Αδιαφάνεια',

    -- APPEARANCE EYES
    ['NUI_EYES_TITLE']                                 = "Χρωματισμός Ματιών",
    ['NUI_EYES_INFO']                                  = "Προσαρμόστε τα μάτια του χαρακτήρα σας — επιλέξτε το ιδανικό χρώμα, σχήμα και λάμψη που ταιριάζουν στην ιστορία του.",
    ['NUI_EYES_TEXTURE_ID_TITLE']                      = "Επιλέξτε Χρωματισμό Ματιών",
    
    -- CLOTHING SECTION
    ['NUI_CLOTHING_INFO']                              = "Προσαρμόστε την ενδυμασία του χαρακτήρα σας σύμφωνα με τις προτιμήσεις σας.",
    ['NUI_CATEGORY_CLOTHING_COATCLOSED_TITLE']         = "Ένα πλήρως κουμπωμένο ή προσδεδεμένο πανωφόρι που προσδίδει επίσημη, εκλεπτυσμένη όψη.",
    ['NUI_CATEGORY_CLOTHING_COAT_TITLE']               = "Ένα ανοιχτό ή μερικώς προσδεδεμένο εξωτερικό ένδυμα που φοριέται πάνω από άλλα ρούχα.",
    ['NUI_CATEGORY_CLOTHING_HAT_TITLE']                = "Ένα αξεσουάρ κεφαλής που ορίζει το περίγραμμα και την προσωπικότητα.",
    ['NUI_CATEGORY_CLOTHING_EYEWEAR_TITLE']            = "Γυαλιά, προστατευτικά ή σκιές που προσθέτουν λειτουργία ή μυστήριο.",
    ['NUI_CATEGORY_CLOTHING_MASK_TITLE']               = "Καλύπτει το πρόσωπο εν μέρει ή πλήρως για μεταμφίεση ή προστασία.",
    ['NUI_CATEGORY_CLOTHING_NECKWEAR_TITLE']           = "Κασκόλ, κολιέ ή περιτυλίγματα που φοριούνται γύρω από τον λαιμό.",
    ['NUI_CATEGORY_CLOTHING_NECKTIES_TITLE']           = "Επίσημοι ή διακοσμητικοί δεσμοί που συμπληρώνουν πουκάμισα και γιλέκα.",
    ['NUI_CATEGORY_CLOTHING_SHIRT_TITLE']              = "Το βασικό επάνω ένδυμα του σώματος, διαθέσιμο σε ποικίλα στυλ και υφάσματα.",
    ['NUI_CATEGORY_CLOTHING_SUSPENDER_TITLE']          = "Τιράντες που στερεώνονται στα παντελόνια, δίνοντας ρετρό ή εργατική όψη.",
    ['NUI_CATEGORY_CLOTHING_VEST_TITLE']               = "Ένα αμάνικο ένδυμα που φοριέται πάνω από πουκάμισο, προσθέτοντας στυλ ή επιπλέον προστασία.",
    ['NUI_CATEGORY_CLOTHING_PONCHO_TITLE']             = "Ένα χαλαρό, πεσμένο ένδυμα που προσφέρει προστασία από τον καιρό ή μια σκληρή εμφάνιση.",
    ['NUI_CATEGORY_CLOTHING_CLOAK_TITLE']              = "Ένα μακρύ, ρέον εξωτερικό ένδυμα που συχνά χρησιμοποιείται για δραματική εμφάνιση ή απόκρυψη.",
    ['NUI_CATEGORY_CLOTHING_GLOVE_TITLE']              = "Ενδύματα χεριών για ζέστη, κράτημα ή στυλ.",
    ['NUI_CATEGORY_CLOTHING_BELT_TITLE']               = "Στερεώνει το παντελόνι και προσθέτει λεπτομέρεια ή διακόσμηση.",
    ['NUI_CATEGORY_CLOTHING_PANT_TITLE']               = "Κανονικό ένδυμα για τα πόδια· καθορίζει το βασικό στυλ για το κάτω μέρος.",
    ['NUI_CATEGORY_CLOTHING_BOOTS_TITLE']              = "Ανθεκτικά υποδήματα που ορίζουν τη στάση και το στυλ του χαρακτήρα.",
    ['NUI_CATEGORY_CLOTHING_SPURS_TITLE']              = "Μεταλλικά εξαρτήματα σε μπότες που χρησιμοποιούνται από ιππείς· προσθέτουν δυτική ή τραχιά νότα.",
    ['NUI_CATEGORY_CLOTHING_BRACELET_TITLE']           = "Αξεσουάρ καρπού που προσθέτει λεπτομέρεια ή προσωπική νότα.",
    ['NUI_CATEGORY_CLOTHING_BUCKLE_TITLE']             = "Το διακοσμητικό ή λειτουργικό κούμπωμα μιας ζώνης ή λουριού.",
    ['NUI_CATEGORY_CLOTHING_CHAP_TITLE']               = "Δερμάτινες επενδύσεις ποδιών που φοριούνται πάνω από παντελόνια, συχνά από ιππείς.",
    ['NUI_CATEGORY_CLOTHING_SPATS_TITLE']              = "Υφασμάτινες ή δερμάτινες επενδύσεις για την πάνω πλευρά των μπότων, που προσθέτουν φινέτσα ή στυλ.",
    ['NUI_CATEGORY_CLOTHING_GAUNTLETS_TITLE']          = "Επιμηκυσμένα γάντια που καλύπτουν μέρος του αντιβραχίου· συχνά πανοπλία ή διακοσμητικά.",
    ['NUI_CATEGORY_CLOTHING_DRESS_TITLE']              = "Ένα ολόσωμο ένδυμα συχνά συνδεδεμένο με κομψότητα ή επίσημο ντύσιμο.",
    ['NUI_CATEGORY_CLOTHING_HOLSTER_TITLE']            = "Θήκη για όπλα ή εργαλεία, συνήθως φοριέται στο ισχίο ή στο στήθος.",
    ['NUI_CATEGORY_CLOTHING_LOADOUTS_TITLE']           = "Πλήρη σύνολα εξοπλισμού που ορίζουν τη λειτουργική ή θεματική εμφάνιση ενός χαρακτήρα.",
    ['NUI_CATEGORY_CLOTHING_ACCESSORIES_TITLE']        = "Διάφορα διακοσμητικά ή λειτουργικά πρόσθετα.",
    ['NUI_CATEGORY_CLOTHING_SATCHELS_TITLE']           = "Τσαντάκια ώμου ή θήκες για τη μεταφορά αντικειμένων.",
    ['NUI_CATEGORY_CLOTHING_HOLSTER_TITLE']            = "Θήκη για όπλα ή εργαλεία, συνήθως φοριέται στο ισχίο ή στο στήθος.",
    ['NUI_CATEGORY_CLOTHING_GUNBELT_TITLE']            = "Ειδική ζώνη σχεδιασμένη για να φέρει θήκες και πυρομαχικά.",
    ['NUI_CATEGORY_CLOTHING_RINGRH_TITLE']             = "Δαχτυλίδι φορεμένο στο δεξί χέρι.",
    ['NUI_CATEGORY_CLOTHING_RINGLH_TITLE']             = "Δαχτυλίδι φορεμένο στο αριστερό χέρι.",
    ['NUI_TINT_1']                                     = "Προσαρμοσμένη Απόχρωση (1)",
    ['NUI_TINT_2']                                     = "Προσαρμοσμένη Απόχρωση (2)",
    ['NUI_TINT_3']                                     = "Προσαρμοσμένη Απόχρωση (3)",
    
    ['NUI_BACK']                                       = "Πίσω",
    
    ['CUSTOMIZE_CLOTHING_DESCRIPTION']                 = "Προσαρμόστε τις ενδυμασίες του νέου χαρακτήρα", 
    ['TOTAL_TYPES']                                    = "Συνολικοί Τύποι: ",
    
    ['ACCEPT_BUTTON']                                  = "ΑΠΟΔΟΧΗ",
    ['DECLINE_BUTTON']                                 = "ΑΠΟΡΡΙΨΗ",
    
    ["CoatClosed"]                                     = "Κουμπωμένα Παλτά",
    ["Coat"]                                           = "Πανοφόρια",
    ["Hat"]                                            = "Καπέλα",
    ["EyeWear"]                                        = "Γυαλιά",
    ["Mask"]                                           = "Μάσκες",
    ["NeckWear"]                                       = "Εξάρτημα Λαιμού",
    ["NeckTies"]                                       = "Γραβάτες",
    ["Shirt"]                                          = "Πουκάμισα",
    ["Suspender"]                                      = "Τιράντες",
    ["Vest"]                                           = "Γιλέκα",
    ["Poncho"]                                         = "Πόντσο",
    ["Cloak"]                                          = "Κάπες",
    ["Glove"]                                          = "Γάντια",
    ["Belt"]                                           = "Ζώνες",
    ["Pant"]                                           = "Παντελόνια",
    ["Boots"]                                          = "Μπότες",
    ["Spurs"]                                          = "Σπιρούνια",
    ["Bracelet"]                                       = "Βραχιόλια",
    ["Buckle"]                                         = "Κούμπωμα Ζώνης",
    ["Skirt"]                                          = "Φούστες",
    ["Chap"]                                           = "Chaps",
    ["Spats"]                                          = "Spats",
    ["GunbeltAccs"]                                    = "Αξεσουάρ Ζώνης Όπλων",
    ["Gauntlets"]                                      = "Γκάντλετ",
    ["Loadouts"]                                       = "Σετ Εξοπλισμού",
    ["Accessories"]                                    = "Αξεσουάρ",
    ["Satchels"]                                       = "Τσάντες Ώμου",
    ["Dress"]                                          = "Φορέματα",
    ["Holster"]                                        = "Left Holster",
    ["Gunbelt"]                                        = "Ζώνες Όπλων",
    ["RingRh"]                                         = "Δαχτυλίδια Δεξιά",
    ["RingLh"]                                         = "Δαχτυλίδια Αριστερά",
    
    ['CREATE_CHARACTER_INVALID_IDENTIFICATION']        = "Οι προσωπικές σας πληροφορίες ταυτότητας είναι άκυρες ή λείπουν.",
    ['CREATE_CHARACTER_INVALID_FIRSTNAME']             = "Το όνομά σας είναι άκυρο, παρακαλώ εισάγετε ένα έγκυρο όνομα για τον χαρακτήρα σας.",
    ['CREATE_CHARACTER_INVALID_LASTNAME']              = "Το επώνυμό σας είναι άκυρο, παρακαλώ εισάγετε ένα έγκυρο επώνυμο για τον χαρακτήρα σας.",
    ['CREATE_CHARACTER_BLACKLISTED_FIRST_OR_LASTNAME'] = "Το όνομα ή το επώνυμό σας περιέχει ακατάλληλες λέξεις — παρακαλώ επιδείξτε σεβασμό.",
    ['CREATE_CHARACTER_NOT_PERMITTED_YEAR']            = "Η εισαγωγή έτους στη φόρμα ημερομηνίας γέννησης δεν μπορεί να γίνει δεκτή· επιλέξτε ένα έτος μεταξύ %s - %s.",
    
    ["CHARACTER_NOT_SELECTED"]                         = "~e~Character not selected", -- not translatable for many languages.
    ["CHARACTER_RELOADED"]                             = "Character reloaded!", -- not translatable for many languages.
    ['CHARACTER_RELOAD_NOT_PERMITTED']                 = "You are not allowed to reload player skin.", -- not translatable for many languages.
    
    ['DEVTOOLS_INJECTION_DETECTED_TITLE_LOG']          = "DevTools / Injection Cheat Found!",
    ['DEVTOOLS_INJECTION_DETECTED']                    = "You have been kicked due to cheating by using DevTools or Injection cheat.",
    
    ['RELOAD_CHARACTER_COMMAND_COOLDOWN']              = "~e~You can't do that for the next %s seconds.", -- not translatable for many languages.
    
}

---------------------------------------------------------------
--[[ EDIT SELECTED LANGUAGE ]]--
---------------------------------------------------------------

-- [ README ]
-- #1 IN CASE THE LANGUAGE IS NOT SUPPORTED, YOU HAVE TO REPLACE THE USED FONTS FROM THE CSS FILES.
-- THE USED FONT IS crock.ttf

-- #2 THERE ARE SOME TEXTS THAT ARE NOT TRANSLATABLE THROUGH THIS FILE, CHECKOUT components_config 
-- and index.html

Citizen.CreateThread(function()
    Wait(2000)

    if Config.LANGUAGE == 'GR' then -- <- MODIFY 'GR' TO DESIRED LANGUAGE OPTION TO BE USED ON Config.LANGUAGE
        Locales = locales
    end

end)
