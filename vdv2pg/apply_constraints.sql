set client_min_messages = warning;

create table if not exists "basis_ver_gueltigkeit" (
    "ver_gueltigkeit" integer not null,
    "basis_version" integer
);
create table if not exists "einzelanschluss" (
    "basis_version" integer default 0 not null,
    "einan_nr" integer default 0 not null,
    "anschluss_name" character varying(40),
    "anschluss_gruppe" character varying(6),
    "leitstellenkennung" integer default 0,
    "zub_li_nr" integer default 0,
    "zub_li_ri_nr" integer default 0,
    "zub_ort_ref_ort" integer default 0,
    "zub_onr_typ_nr" integer,
    "zub_ort_nr" integer,
    "von_ort_ref_ort" integer,
    "linienid" character varying(6),
    "richtungsid" character varying(6),
    "asbid" character varying(10),
    "abb_li_nr" integer default 0,
    "abb_li_ri_nr" integer default 0,
    "abb_ort_ref_ort" integer default 0,
    "abb_onr_typ_nr" integer,
    "abb_ort_nr" integer,
    "nach_ort_ref_ort" integer
);
create table if not exists "fahrzeug" (
    "basis_version" integer not null,
    "fzg_nr" integer not null,
    "fzg_typ_nr" integer,
    "polkenn" character varying(20),
    "unternehmen" integer
);
create table if not exists "firmenkalender" (
    "basis_version" integer not null,
    "betriebstag" integer not null,
    "betriebstag_text" character varying(40),
    "tagesart_nr" integer
);
create table if not exists "flaechen_zone" (
    "basis_version" integer not null,
    "fl_zone_typ_nr" integer not null,
    "fl_zone_nr" integer not null,
    "fl_zone_kuerzel" character varying(8),
    "fl_zone_name" character varying(40),
    "fl_amtliche_nr" character varying(20)
);
create table if not exists "fl_zone_ort" (
    "basis_version" integer not null,
    "fl_zone_typ_nr" integer not null,
    "fl_zone_nr" integer,
    "onr_typ_nr" integer,
    "ort_nr" integer
);
create table if not exists "lid_verlauf" (
    "basis_version" integer not null,
    "li_lfd_nr" integer not null,
    "li_nr" integer not null,
    "str_li_var" character varying(6) not null,
    "onr_typ_nr" integer,
    "ort_nr" integer,
    "znr_nr" integer,
    "anr_nr" integer,
    "einfangbereich" integer,
    "li_knoten" boolean default true,
    "produktiv" boolean default true,
    "einsteigeverbot" boolean default false,
    "aussteigeverbot" boolean default false,
    "innerortsverbot" boolean default false,
    "bedarfshalt" boolean default false
);
create table if not exists "menge_basis_versionen" (
    "basis_version" integer not null,
    "basis_version_text" character varying(40)
);
create table if not exists "menge_bereich" (
    "basis_version" integer not null,
    "bereich_nr" integer not null,
    "str_bereich" character varying(6),
    "bereich_text" character varying(40)
);
create table if not exists "menge_fahrtart" (
    "basis_version" integer not null,
    "fahrtart_nr" integer not null,
    "str_fahrtart" character varying(6)
);
create table if not exists "menge_fgr" (
    "basis_version" integer not null,
    "fgr_nr" integer not null,
    "fgr_text" character varying(40)
);
create table if not exists "menge_fzg_typ" (
    "basis_version" integer not null,
    "fzg_typ_nr" integer not null,
    "fzg_laenge" integer,
    "fzg_typ_sitz" integer,
    "fzg_typ_steh" integer,
    "fzg_typ_text" character varying(40),
    "sonder_platz" integer,
    "str_fzg_typ" character varying(6)
);
create table if not exists "menge_onr_typ" (
    "basis_version" integer not null,
    "onr_typ_nr" integer not null,
    "str_onr_typ" character varying(6),
    "onr_typ_text" character varying(40)
);
create table if not exists "menge_ort_typ" (
    "basis_version" integer not null,
    "ort_typ_nr" integer not null,
    "ort_typ_text" character varying(40)
);
create table if not exists "menge_tagesart" (
    "basis_version" integer not null,
    "tagesart_nr" integer not null,
    "tagesart_text" character varying(40)
);
create table if not exists "ort_hztf" (
    "basis_version" integer not null,
    "fgr_nr" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "hp_hzt" integer
);
create table if not exists "rec_anr" (
    "basis_version" integer not null,
    "anr_nr" integer not null,
    "anr_text" character varying(200)
);
create table if not exists "rec_frt" (
    "basis_version" integer not null,
    "frt_fid" integer not null,
    "frt_start" integer,
    "li_nr" integer,
    "tagesart_nr" integer,
    "li_ku_nr" integer,
    "fahrtart_nr" integer,
    "fgr_nr" integer,
    "str_li_var" character varying(6),
    "um_uid" integer,
    "zugnr" integer,
    "durchbi_frt_start" boolean default false,
    "durchbi_frt_ende" boolean default false
);
create table if not exists "rec_frt_hzt" (
    "basis_version" integer not null,
    "frt_fid" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "frt_hzt_zeit" integer
);
create table if not exists "rec_hp" (
    "basis_version" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "haltepunkt_nr" integer,
    "zusatz_info" character varying(40)
);
create table if not exists "rec_lid" (
    "basis_version" integer not null,
    "li_nr" integer not null,
    "str_li_var" character varying(6) not null,
    "routen_nr" integer,
    "li_ri_nr" integer,
    "bereich_nr" integer,
    "li_kuerzel" character varying(6),
    "lidname" character varying(40),
    "routen_art" integer,
    "linien_code" integer
);
create table if not exists "rec_om" (
    "basis_version" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "orm_kuerzel" character varying(6),
    "ormacode" integer,
    "orm_text" character varying(40)
);
create table if not exists "rec_ort" (
    "basis_version" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "ort_name" character varying(40),
    "ort_ref_ort" integer,
    "ort_ref_ort_typ" integer,
    "ort_ref_ort_langnr" integer,
    "ort_ref_ort_kuerzel" character varying(8),
    "ort_ref_ort_name" character varying(40),
    "zone_wabe_nr" integer,
    "ort_pos_laenge" integer default 0,
    "ort_pos_breite" integer default 0,
    "ort_pos_hoehe" integer default 0,
    "ort_richtung" integer default 0,
    "hast_nr_lokal" integer,
    "hst_nr_national" integer,
    "hst_nr_international" character varying(30)
);
create table if not exists "rec_sel" (
    "basis_version" integer not null,
    "bereich_nr" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "sel_ziel" integer not null,
    "sel_ziel_typ" integer not null,
    "sel_laenge" integer
);
create table if not exists "rec_sel_zp" (
    "basis_version" integer not null,
    "bereich_nr" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "sel_ziel" integer not null,
    "sel_ziel_typ" integer not null,
    "zp_onr" integer not null,
    "zp_typ" integer not null,
    "sel_zp_laenge" integer,
    "zp_lfd_nr" integer default 0
);
create table if not exists "rec_ueb" (
    "basis_version" integer not null,
    "bereich_nr" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "ueb_ziel_typ" integer not null,
    "ueb_ziel" integer not null,
    "ueb_laenge" integer
);
create table if not exists "rec_umlauf" (
    "basis_version" integer not null,
    "tagesart_nr" integer not null,
    "um_uid" integer not null,
    "anf_ort" integer,
    "anf_onr_typ" integer,
    "end_ort" integer,
    "end_onr_typ" integer,
    "fzg_typ_nr" integer
);
create table if not exists "rec_ums" (
    "basis_version" integer default 0 not null,
    "einan_nr" integer default 0 not null,
    "tagesart_nr" integer default 0 not null,
    "ums_beginn" integer default 0 not null,
    "ums_ende" integer default 0 not null,
    "ums_min" integer default 0,
    "ums_max" integer default 0,
    "max_verz_man" integer default 0,
    "max_verz_auto" integer default 0
);
create table if not exists "rec_znr" (
    "basis_version" integer not null,
    "znr_nr" integer not null,
    "faherekurztext" character varying(44),
    "seitentext" character varying(160),
    "znr_text" character varying(160),
    "znr_code" character varying(68)
);
create table if not exists "sel_fzt_feld" (
    "basis_version" integer not null,
    "bereich_nr" integer not null,
    "fgr_nr" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "sel_ziel" integer not null,
    "sel_ziel_typ" integer not null,
    "sel_fzt" integer
);
create table if not exists "ueb_fzt" (
    "basis_version" integer not null,
    "bereich_nr" integer not null,
    "fgr_nr" integer not null,
    "onr_typ_nr" integer not null,
    "ort_nr" integer not null,
    "ueb_ziel_typ" integer not null,
    "ueb_ziel" integer not null,
    "ueb_fahrzeit" integer
);
create table if not exists "zul_verkehrsbetrieb" (
    "basis_version" integer not null,
    "unternehmen" integer not null,
    "abk_unternehmen" character varying(6),
    "betriebsgebiet_bez" character varying(40)
);
alter table only "basis_ver_gueltigkeit"
    add constraint "basis_ver_gueltigkeit_pkey" primary key ("ver_gueltigkeit");
alter table only "einzelanschluss"
    add constraint "einzelanschluss_pkey" primary key ("basis_version", "einan_nr");
alter table only "fahrzeug"
    add constraint "fahrzeug_pkey" primary key ("basis_version", "fzg_nr");
alter table only "firmenkalender"
    add constraint "firmenkalender_pkey" primary key ("basis_version", "betriebstag");
alter table only "flaechen_zone"
    add constraint "flaechen_zone_pkey" primary key ("basis_version", "fl_zone_typ_nr", "fl_zone_nr");
alter table only "fl_zone_ort"
    add constraint "fl_zone_ort_pkey" primary key ("basis_version", "fl_zone_typ_nr");
alter table only "lid_verlauf"
    add constraint "lid_verlauf_pkey" primary key ("basis_version", "li_lfd_nr", "li_nr", "str_li_var");
alter table only "menge_basis_versionen"
    add constraint "menge_basis_versionen_pkey" primary key ("basis_version");
alter table only "menge_bereich"
    add constraint "menge_bereich_pkey" primary key ("basis_version", "bereich_nr");
alter table only "menge_fahrtart"
    add constraint "menge_fahrtart_pkey" primary key ("basis_version", "fahrtart_nr");
alter table only "menge_fgr"
    add constraint "menge_fgr_pkey" primary key ("basis_version", "fgr_nr");
alter table only "menge_fzg_typ"
    add constraint "menge_fzg_typ_pkey" primary key ("basis_version", "fzg_typ_nr");
alter table only "menge_onr_typ"
    add constraint "menge_onr_typ_pkey" primary key ("basis_version", "onr_typ_nr");
alter table only "menge_ort_typ"
    add constraint "menge_ort_typ_pkey" primary key ("basis_version", "ort_typ_nr");
alter table only "menge_tagesart"
    add constraint "menge_tagesart_pkey" primary key ("basis_version", "tagesart_nr");
alter table only "ort_hztf"
    add constraint "ort_hztf_pkey" primary key ("basis_version", "fgr_nr", "onr_typ_nr", "ort_nr");
alter table only "rec_anr"
    add constraint "rec_anr_pkey" primary key ("basis_version", "anr_nr");
alter table only "rec_frt_hzt"
    add constraint "rec_frt_hzt_pkey" primary key ("basis_version", "frt_fid", "onr_typ_nr", "ort_nr");
alter table only "rec_frt"
    add constraint "rec_frt_pkey" primary key ("basis_version", "frt_fid");
alter table only "rec_hp"
    add constraint "rec_hp_pkey" primary key ("basis_version", "onr_typ_nr", "ort_nr");
alter table only "rec_lid"
    add constraint "rec_lid_pkey" primary key ("basis_version", "li_nr", "str_li_var");
-- EINZELANSCHLUSS only has columns for the following attributes, comment out the next four lines to add a foreign key (does not work with all datasets):
-- alter table only "rec_lid"
--    add constraint "rec_lid_li_ri_nr_uq" unique ("basis_version", "li_nr", "li_ri_nr");
-- alter table only "einzelanschluss"
--    add foreign key ("basis_version", "abb_li_nr", "abb_li_ri_nr") references "rec_lid"("basis_version", "li_nr","li_ri_nr");
alter table only "rec_om"
    add constraint "rec_om_pkey" primary key ("basis_version", "onr_typ_nr", "ort_nr");
alter table only "rec_ort"
    add constraint "rec_ort_pkey" primary key ("basis_version", "onr_typ_nr", "ort_nr");
alter table only "rec_sel_zp"
    add constraint "rec_sel_zp_pkey" primary key ("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "sel_ziel", "sel_ziel_typ", "zp_onr", "zp_typ");
alter table only "rec_sel"
    add constraint "rec_sel_pkey" primary key ("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "sel_ziel", "sel_ziel_typ");
alter table only "rec_ueb"
    add constraint "rec_ueb_pkey" primary key ("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "ueb_ziel_typ", "ueb_ziel");
alter table only "rec_umlauf"
    add constraint "rec_umlauf_pkey" primary key ("basis_version", "tagesart_nr", "um_uid");
alter table only "rec_ums"
    add constraint "rec_ums_pkey" primary key ("basis_version", "einan_nr", "tagesart_nr", "ums_beginn", "ums_ende");
alter table only "rec_znr"
    add constraint "rec_znr_pkey" primary key ("basis_version", "znr_nr");
alter table only "sel_fzt_feld"
    add constraint "sel_fzt_feld_pkey" primary key ("basis_version", "bereich_nr", "fgr_nr", "onr_typ_nr", "ort_nr", "sel_ziel", "sel_ziel_typ");
alter table only "ueb_fzt"
    add constraint "ueb_fzt_pkey" primary key ("basis_version", "bereich_nr", "fgr_nr", "onr_typ_nr", "ort_nr", "ueb_ziel_typ", "ueb_ziel");
alter table only "zul_verkehrsbetrieb"
    add constraint "zul_verkehrsbetrieb_pkey" primary key ("basis_version", "unternehmen");
create index on "einzelanschluss" using btree ("abb_li_nr");
create index on "einzelanschluss" using btree ("abb_li_ri_nr");
create index on "einzelanschluss" using btree ("asbid");
create index on "einzelanschluss" using btree ("basis_version");
create index on "einzelanschluss" using btree ("linienid");
create index on "einzelanschluss" using btree ("richtungsid");
create index on "einzelanschluss" using btree ("zub_li_nr");
create index on "einzelanschluss" using btree ("zub_li_ri_nr");
create index on "flaechen_zone" using btree ("fl_zone_typ_nr");
create index on "fl_zone_ort" using btree ("fl_zone_typ_nr");
create index on "fl_zone_ort" using btree ("fl_zone_nr");
create index on "lid_verlauf" using btree ("basis_version");
create index on "menge_basis_versionen" using btree ("basis_version");
create index on "menge_bereich" using btree ("bereich_nr");
create index on "menge_fgr" using btree ("fgr_nr");
create index on "menge_fzg_typ" using btree ("fzg_typ_nr");
create index on "menge_onr_typ" using btree ("basis_version");
create index on "menge_onr_typ" using btree ("onr_typ_nr");
create index on "rec_frt" using btree ("frt_fid");
create index on "rec_frt_hzt" using btree ("frt_fid");
create index on "rec_frt" using btree ("basis_version");
create index on "rec_frt" using btree ("str_li_var");
create index on "rec_frt" using btree ("um_uid");
create index on "rec_lid" using btree ("linien_code");
create index on "rec_lid" using btree ("li_nr");
create index on "rec_lid" using btree ("li_ri_nr");
create index on "rec_lid" using btree ("basis_version");
create index on "rec_lid" using btree ("str_li_var");
create index on "rec_om" using btree ("ormacode");
create index on "rec_ort" using btree ("basis_version");
create index on "rec_sel" using btree ("bereich_nr");
create index on "rec_umlauf" using btree ("basis_version");
create index on "rec_umlauf" using btree ("fzg_typ_nr");
create index on "rec_umlauf" using btree ("um_uid");
create index on "rec_ums" using btree ("einan_nr");
create index on "rec_znr" using btree ("znr_code");
alter table only "rec_ums"
    add foreign key ("basis_version", "einan_nr") references "einzelanschluss"("basis_version", "einan_nr");
alter table only "fl_zone_ort"
    add foreign key ("fl_zone_typ_nr", "basis_version", "fl_zone_nr") references "flaechen_zone"("fl_zone_typ_nr", "basis_version", "fl_zone_nr");
alter table only "basis_ver_gueltigkeit"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "menge_bereich"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "menge_fzg_typ"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "menge_onr_typ"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "menge_ort_typ"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "menge_tagesart"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "rec_lid"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "zul_verkehrsbetrieb"
    add foreign key ("basis_version") references "menge_basis_versionen"("basis_version");
alter table only "rec_sel"
    add foreign key ("basis_version", "bereich_nr") references "menge_bereich"("basis_version", "bereich_nr");
alter table only "rec_ueb"
    add foreign key ("basis_version", "bereich_nr") references "menge_bereich"("basis_version", "bereich_nr");
alter table only "rec_frt"
    add foreign key ("basis_version", "fahrtart_nr") references "menge_fahrtart"("basis_version", "fahrtart_nr");
alter table only "ort_hztf"
    add foreign key ("basis_version", "fgr_nr") references "menge_fgr"("basis_version", "fgr_nr");
alter table only "rec_frt"
    add foreign key ("basis_version", "fgr_nr") references "menge_fgr"("basis_version", "fgr_nr");
alter table only "sel_fzt_feld"
    add foreign key ("basis_version", "fgr_nr") references "menge_fgr"("basis_version", "fgr_nr");
alter table only "ueb_fzt"
    add foreign key ("basis_version", "fgr_nr") references "menge_fgr"("basis_version", "fgr_nr");
alter table only "fahrzeug"
    add foreign key ("basis_version", "fzg_typ_nr") references "menge_fzg_typ"("basis_version", "fzg_typ_nr");
alter table only "rec_umlauf"
    add foreign key ("basis_version", "fzg_typ_nr") references "menge_fzg_typ"("basis_version", "fzg_typ_nr");
alter table only "rec_hp"
    add foreign key ("basis_version", "onr_typ_nr") references "menge_onr_typ"("basis_version", "onr_typ_nr");
alter table only "rec_ort"
    add foreign key ("basis_version", "ort_ref_ort_typ") references "menge_ort_typ"("basis_version", "ort_typ_nr");
alter table only "firmenkalender"
    add foreign key ("basis_version", "tagesart_nr") references "menge_tagesart"("basis_version", "tagesart_nr");
alter table only "rec_umlauf"
    add foreign key ("basis_version", "tagesart_nr") references "menge_tagesart"("basis_version", "tagesart_nr");
alter table only "lid_verlauf"
    add foreign key ("basis_version", "anr_nr") references "rec_anr"("basis_version", "anr_nr");
alter table only "rec_frt_hzt"
    add foreign key ("basis_version", "frt_fid") references "rec_frt"("basis_version", "frt_fid");
alter table only "lid_verlauf"
    add foreign key ("basis_version", "li_nr", "str_li_var") references "rec_lid"("basis_version", "li_nr", "str_li_var");
alter table only "rec_frt"
    add foreign key ("basis_version", "li_nr", "str_li_var") references "rec_lid"("basis_version", "li_nr", "str_li_var");
alter table only "lid_verlauf"
    add foreign key ("basis_version", "onr_typ_nr", "ort_nr") references "rec_ort"("basis_version", "onr_typ_nr", "ort_nr");
alter table only "ort_hztf"
    add foreign key ("basis_version", "onr_typ_nr", "ort_nr") references "rec_ort"("basis_version", "onr_typ_nr", "ort_nr");
alter table only "rec_hp"
    add foreign key ("basis_version", "onr_typ_nr", "ort_nr") references "rec_ort"("basis_version", "onr_typ_nr", "ort_nr");
alter table only "rec_om"
    add foreign key ("basis_version", "onr_typ_nr", "ort_nr") references "rec_ort"("basis_version", "onr_typ_nr", "ort_nr");
alter table only "rec_sel_zp"
    add foreign key ("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "sel_ziel", "sel_ziel_typ") references "rec_sel"("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "sel_ziel", "sel_ziel_typ");
alter table only "sel_fzt_feld"
    add foreign key ("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "sel_ziel", "sel_ziel_typ") references "rec_sel"("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "sel_ziel", "sel_ziel_typ");
alter table only "ueb_fzt"
    add foreign key ("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "ueb_ziel_typ", "ueb_ziel") references "rec_ueb"("basis_version", "bereich_nr", "onr_typ_nr", "ort_nr", "ueb_ziel_typ", "ueb_ziel");
alter table only "rec_frt"
    add foreign key ("basis_version", "tagesart_nr", "um_uid") references "rec_umlauf"("basis_version", "tagesart_nr", "um_uid");
alter table only "fahrzeug"
    add foreign key ("basis_version", "unternehmen") references "zul_verkehrsbetrieb"("basis_version", "unternehmen");
