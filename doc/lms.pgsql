BEGIN;

/* --------------------------------------------------------
Structure of table "pds"
-------------------------------------------------------- */

DROP SEQUENCE IF EXISTS pds_id_seq;
CREATE SEQUENCE pds_id_seq;

DROP TABLE IF EXISTS pds CASCADE;
CREATE TABLE pds (
    id smallint DEFAULT nextval('pds_id_seq'::text) NOT NULL,
    fullnumber varchar(50) NOT NULL,
    netvalue numeric(9,2) NOT NULL,
    grossvalue numeric(9,2) NOT NULL,
    cdate integer NOT NULL,
    sdate integer NOT NULL,
    deadline integer DEFAULT NULL,
    paydate integer DEFAULT NULL,
    description varchar(254) DEFAULT NULL,
    customerid integer NOT NULL
        CONSTRAINT pds_customerid_fkey REFERENCES customers (id) ON DELETE SET NULL ON UPDATE CASCADE,
    typeid integer DEFAULT NULL
        CONSTRAINT pds_typeid_fkey REFERENCES pdtypes (id) ON DELETE SET NULL ON UPDATE CASCADE,
    PRIMARY KEY (id),
    CONSTRAINT pds_customerid_ukey UNIQUE (fullnumber, customerid)
);

/* --------------------------------------------------------
Structure of table "pdtypes"
-------------------------------------------------------- */

DROP SEQUENCE IF EXISTS pdtypes_id_seq;
CREATE SEQUENCE pdtypes_id_seq;

DROP TABLE IF EXISTS pdtypes CASCADE;
CREATE TABLE pdtypes (
    id smallint DEFAULT nextval('pdtypes_id_seq'::text) NOT NULL,
    name varchar(50) NOT NULL,
    description varchar(254) DEFAULT NULL,
    PRIMARY KEY (id)
);

/* --------------------------------------------------------
Structure of table "pdsprojects"
-------------------------------------------------------- */

DROP SEQUENCE IF EXISTS pdsprojects_id_seq;
CREATE SEQUENCE pdsprojects_id_seq;

DROP TABLE IF EXISTS pdsprojects CASCADE;
CREATE TABLE pdsprojects (
    id smallint DEFAULT nextval('pdsprojects_id_seq'::text) NOT NULL,
    pdid smallint NOT NULL,
    projectid smallint NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO public.pdtypes (id, name, description) VALUES (1, 'faktura VAT', NULL);
INSERT INTO public.pdtypes (id, name, description) VALUES (2, 'faktura VAT-marża', NULL);
INSERT INTO public.pdtypes (id, name, description) VALUES (3, 'korekta', NULL);
INSERT INTO public.pdtypes (id, name, description) VALUES (4, 'rachunek', NULL);
INSERT INTO public.pdtypes (id, name, description) VALUES (5, 'decyzja płatnicza', NULL);
INSERT INTO public.pdtypes (id, name, description) VALUES (6, 'opłata za rachunek bankowy', NULL);
INSERT INTO public.pdtypes (id, name, description) VALUES (7, 'proforma', NULL);
INSERT INTO public.pdtypes (id, name, description) VALUES (8, 'nota księgowa', NULL);

INSERT INTO dbinfo (keytype, keyvalue) VALUES ('dbversion_LMSPurchasesPlugin', '2021116001');

COMMIT;
