create table global_param
(
    id bigint NOT NULL DEFAULT id_generator(),
    company_id bigint,
    category varchar(255),
    key varchar(255),
    value varchar(255),
    sort bigint,
    disabled boolean DEFAULT false,
    created_by bigint,
    created_date bigint,
    updated_by bigint,
    updated_date bigint,
    deleted_by bigint,
    deleted_date bigint,
    version integer DEFAULT 1,
    unique (key),
    CONSTRAINT global_param_pk PRIMARY KEY (id)
);


create table owner_org
(
    id bigint NOT NULL DEFAULT id_generator(),
    parent_id bigint,
    type smallint,
    code varchar(50),
    name varchar(255),
    slogan varchar(255),
    font_icon varchar(255),
    use_font_icon boolean,
    icon_data text,
    house_number varchar(255),
    street varchar(255),
    ward_id bigint,
    district_id bigint,
    city_id bigint,
    country_id bigint,
    tel varchar(255),
    email varchar(255),
    facebook varchar(255),
    twitter varchar(255),
    skype varchar(255),
    website varchar(255),
    sort bigint,
    default_org boolean DEFAULT false,
    disabled boolean DEFAULT false,
    created_by bigint,
    created_date bigint,
    updated_by bigint,
    updated_date bigint,
    deleted_by bigint,
    deleted_date bigint,
    version integer DEFAULT 1,
    CONSTRAINT owner_org_pk PRIMARY KEY (id)
);


create table menu_org
(
    id bigint NOT NULL DEFAULT id_generator(),
    menu_id bigint,
    org_id bigint,
    sort bigint,
    disabled boolean DEFAULT FALSE,
    created_by bigint,
    created_date bigint,
    updated_by bigint,
    updated_date bigint,
    deleted_by bigint,
    deleted_date bigint,
    version integer DEFAULT 1,
    CONSTRAINT menu_org_pk PRIMARY KEY (id)
);

create table role_detail
(
    id bigint NOT NULL DEFAULT id_generator(),
    role_id bigint,
    menu_org_id bigint,
    is_private boolean DEFAULT false,
    data_level smallint,
    approve boolean DEFAULT false,
    disabled boolean DEFAULT false,
    created_by bigint,
    created_date bigint,
    updated_by bigint,
    updated_date bigint,
    deleted_by bigint,
    deleted_date bigint,
    version integer DEFAULT 1,
    CONSTRAINT role_detail_pk PRIMARY KEY (id)
);

create table role
(
    id bigint NOT NULL DEFAULT id_generator(),
    owner_org_id bigint,
    code varchar(50),
    name varchar(255),
    sort bigint,
    disabled boolean DEFAULT FALSE,
    created_by bigint,
    created_date bigint,
    updated_by bigint,
    updated_date bigint,
    deleted_by bigint,
    deleted_date bigint,
    version integer DEFAULT 1,
    CONSTRAINT role_pk PRIMARY KEY (id)
);


create table assignment_role
(
    id bigint NOT NULL DEFAULT id_generator(),
    role_id bigint,
    user_id bigint,
    disabled boolean DEFAULT FALSE,
    created_by bigint,
    created_date bigint,
    updated_by bigint,
    updated_date bigint,
    deleted_by bigint,
    deleted_date bigint,
    version integer DEFAULT 1,
    CONSTRAINT assignment_role_pk PRIMARY KEY (id)
);