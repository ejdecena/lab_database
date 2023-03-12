/* CREA LA BASE DE DATOS */

drop table if exists categoria cascade;
create table categoria
(
    id_categoria serial,
    nom_categoria varchar(20),
    constraint pk_categoria_id primary key (id_categoria),
    constraint un_categoria_nom_categoria unique (nom_categoria)
);

drop table if exists producto;
create table producto
(
    id_producto serial,
    id_categoria bigint not null,
    nom_producto varchar(20),
    constraint pk_producto_id_producto primary key (id_producto),
	constraint fk_producto_id_categoria foreign key (id_categoria) references categoria(id_categoria) on update cascade on delete restrict
);