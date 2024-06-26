(define-resource file ()
  :class (s-prefix "nfo:FileDataObject")
  :properties `((:name :string ,(s-prefix "nfo:fileName"))
                (:format :string ,(s-prefix "dct:format"))
                (:size :number ,(s-prefix "nfo:fileSize"))
                (:extension :string ,(s-prefix "dbpedia:fileExtension"))
                (:created :datetime ,(s-prefix "nfo:fileCreated")))
  :has-one `((data-source :via ,(s-prefix "nie:dataSource")
                          :as "data-source")
             (data-container :via ,(s-prefix "task:hasFile")
                             :inverse t
                             :as "data-container")
              )
  :resource-base (s-url "http://data.lblod.info/files/")
  :features `(include-uri)
  :on-path "files")

(define-resource remote-data-object ()
  :class (s-prefix "nfo:RemoteDataObject")
  :properties `((:source :url ,(s-prefix "nie:url"))
                (:created :datetime ,(s-prefix "dct:created"))
                (:modified :datetime ,(s-prefix "dct:modified"))
                (:request-header :url ,(s-prefix "rpioHttp:requestHeader"))
                (:status :url ,(s-prefix "adms:status"))
                (:comment :string ,(s-prefix "skos:comment"))
                (:creator :url ,(s-prefix "dct:creator")))
  :has-one `((file :via ,(s-prefix "nie:dataSource")
              :inverse t
              :as "file")
            (harvesting-collection :via ,(s-prefix "dct:hasPart")
              :inverse t
              :as "harvesting-collection")
            (authentication-configuration :via ,(s-prefix "dgftSec:targetAuthenticationConfiguration")
              :as "authentication-configuration"))
  :resource-base (s-url "http://data.lblod.info/id/remote-data-objects/")
  :features `(include-uri)
  :on-path "remote-data-objects")

;;
;; Authentication Configuration
;;

(define-resource authentication-configuration ()
  :class (s-prefix "dgftSec:AuthenticationConfiguration")
  :has-one `((credential :via ,(s-prefix "dgftSec:secrets")
              :as "credential")
            (security-scheme :via ,(s-prefix "dgftSec:securityConfiguration")
              :as "security-scheme"))
  :resource-base (s-url "http://data.lblod.info/id/authentication-configurations/")
  :features `(include-uri)
  :on-path "authentication-configurations")

;;
;; Secrets (Security Credentials)
;;

(define-resource credential ()
  ;; Abstract superclass, so that it can be used in the frontend
  :class (s-prefix "dgftSec:Credentials")
  :resource-base (s-url "http://data.lblod.info/id/credentials/")
  :features '(include-uri)
  :on-path "credentials")

(define-resource basic-authentication-credential (credential)
  :class (s-prefix "dgftSec:BasicAuthenticationCredentials")
  :properties `((:username :string ,(s-prefix "meb:username"))
                (:password :string ,(s-prefix "muAccount:password")))
  :resource-base (s-url "http://data.lblod.info/id/basic-authentication-credentials/")
  :features '(include-uri)
  :on-path "basic-authentication-credentials")

(define-resource oauth2-credential (credential)
  :class (s-prefix "dgftSec:OAuth2Credentials")
  :properties `((:client-id      :string ,(s-prefix "dgftOauth:clientId"))
                (:client-secret  :string ,(s-prefix "dgftOauth:clientSecret")))
  :resource-base (s-url "http://data.lblod.info/id/oauth-2-credentials/")
  :features '(include-uri)
  :on-path "oauth2-credentials")

;;
;; Security Schemes
;;

(define-resource security-scheme ()
  ;; Abstract superclass
  :class (s-prefix "wotSec:SecurityScheme")
  :resource-base (s-url "http://data.lblod.info/id/security-schemes/")
  :features '(include-uri)
  :on-path "security-schemes")

(define-resource basic-security-scheme (security-scheme)
  :class (s-prefix "wotSec:BasicSecurityScheme")
  :resource-base (s-url "http://data.lblod.info/id/basic-security-schemes/")
  :features '(include-uri)
  :on-path "basic-security-schemes")

(define-resource oauth2-security-scheme (security-scheme)
  :class (s-prefix "wotSec:OAuth2SecurityScheme")
  :properties `((:token :string ,(s-prefix "wotSec:token"))
                (:flow  :string ,(s-prefix "wotSec:flow")))
  :resource-base (s-url "http://data.lblod.info/id/oauth2-security-schemes/")
  :features '(include-uri)
  :on-path "oauth2-security-schemes")


(define-resource harvesting-collection ()
  :class (s-prefix "hrvst:HarvestingCollection")
  :properties `((:status :url ,(s-prefix "adms:status"))
                (:creator :url ,(s-prefix "dct:creator")))
  :has-one `((authentication-configuration :via ,(s-prefix "dgftSec:targetAuthenticationConfiguration")
              :as "authentication-configuration"))
  :has-many `((remote-data-object :via ,(s-prefix "dct:hasPart")
                                  :as "remote-data-objects")
              (data-container :via ,(s-prefix "task:hasHarvestingCollection")
                              :inverse t
                              :as "data-container"))
  :resource-base (s-url "http://data.lblod.info/id/harvesting-collection/")
  :features '(include-uri)
  :on-path "harvesting-collections")
