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
alter table only "einzelanschluss"
    add foreign key ("basis_version", "abb_li_nr", "abb_li_ri_nr") references "rec_lid"("basis_version", "li_nr","li_ri_nr");
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
alter table only "lid_verlauf"
    add foreign key ("basis_version", "znr_nr") references "rec_znr"("basis_version", "znr_nr");
alter table only "fahrzeug"
    add foreign key ("basis_version", "unternehmen") references "zul_verkehrsbetrieb"("basis_version", "unternehmen");
