PGDMP                      }            db_productos    17.4    17.4 4    e           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            f           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            g           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            h           1262    16395    db_productos    DATABASE     r   CREATE DATABASE db_productos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-MX';
    DROP DATABASE db_productos;
                     postgres    false                        2615    24640 	   auditoria    SCHEMA        CREATE SCHEMA auditoria;
    DROP SCHEMA auditoria;
                     postgres    false            �            1255    24651    fn_log_audit()    FUNCTION     j  CREATE FUNCTION public.fn_log_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'D', OLD, NULL, now(), USER);
    RETURN OLD;
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'U', OLD, NEW, now(), USER);
    RETURN NEW;
  ELSIF (TG_OP = 'INSERT') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'I', NULL, NEW, now(), USER);
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$$;
 %   DROP FUNCTION public.fn_log_audit();
       public               postgres    false            �            1259    24642    tb_auditoria    TABLE       CREATE TABLE auditoria.tb_auditoria (
    id_aud integer NOT NULL,
    tabla_aud text,
    operacion_aud text,
    valoranterior_aud text,
    valornuevo_aud text,
    fecha_aud date,
    usuario_aud text,
    esquema_aud text,
    activar_aud boolean,
    trigger_aud boolean
);
 #   DROP TABLE auditoria.tb_auditoria;
    	   auditoria         heap r       postgres    false    6            �            1259    24641    tb_auditoria_id_aud_seq    SEQUENCE     �   CREATE SEQUENCE auditoria.tb_auditoria_id_aud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE auditoria.tb_auditoria_id_aud_seq;
    	   auditoria               postgres    false    6    234            i           0    0    tb_auditoria_id_aud_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE auditoria.tb_auditoria_id_aud_seq OWNED BY auditoria.tb_auditoria.id_aud;
       	   auditoria               postgres    false    233            �            1259    24576    tb_categoria    TABLE     \   CREATE TABLE public.tb_categoria (
    id_cat integer NOT NULL,
    descripcion_cat text
);
     DROP TABLE public.tb_categoria;
       public         heap r       postgres    false            �            1259    24581    tb_categoria_id_cat_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_categoria_id_cat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.tb_categoria_id_cat_seq;
       public               postgres    false    218            j           0    0    tb_categoria_id_cat_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.tb_categoria_id_cat_seq OWNED BY public.tb_categoria.id_cat;
          public               postgres    false    219            �            1259    24582    tb_estadocivil    TABLE     ^   CREATE TABLE public.tb_estadocivil (
    id_est integer NOT NULL,
    descripcion_est text
);
 "   DROP TABLE public.tb_estadocivil;
       public         heap r       postgres    false            �            1259    24587    tb_estadocivil_id_est_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_estadocivil_id_est_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.tb_estadocivil_id_est_seq;
       public               postgres    false    220            k           0    0    tb_estadocivil_id_est_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.tb_estadocivil_id_est_seq OWNED BY public.tb_estadocivil.id_est;
          public               postgres    false    221            �            1259    24588 	   tb_pagina    TABLE     l   CREATE TABLE public.tb_pagina (
    id_pag integer NOT NULL,
    descripcion_pag text,
    path_pag text
);
    DROP TABLE public.tb_pagina;
       public         heap r       postgres    false            �            1259    24624    tb_pagina_id_pag_seq    SEQUENCE     �   ALTER TABLE public.tb_pagina ALTER COLUMN id_pag ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tb_pagina_id_pag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    222            �            1259    24593    tb_parametros    TABLE     q   CREATE TABLE public.tb_parametros (
    id_par integer NOT NULL,
    descripcion_par text,
    valor_par text
);
 !   DROP TABLE public.tb_parametros;
       public         heap r       postgres    false            �            1259    24598 	   tb_perfil    TABLE     Y   CREATE TABLE public.tb_perfil (
    id_per integer NOT NULL,
    descripcion_per text
);
    DROP TABLE public.tb_perfil;
       public         heap r       postgres    false            �            1259    24625    tb_perfil_id_per_seq    SEQUENCE     �   ALTER TABLE public.tb_perfil ALTER COLUMN id_per ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tb_perfil_id_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    224            �            1259    24603    tb_perfilpagina    TABLE     p   CREATE TABLE public.tb_perfilpagina (
    id_perpag integer NOT NULL,
    id_per integer,
    id_pag integer
);
 #   DROP TABLE public.tb_perfilpagina;
       public         heap r       postgres    false            �            1259    24606    tb_perfilpagina_id_perpag_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_perfilpagina_id_perpag_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.tb_perfilpagina_id_perpag_seq;
       public               postgres    false    225            l           0    0    tb_perfilpagina_id_perpag_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.tb_perfilpagina_id_perpag_seq OWNED BY public.tb_perfilpagina.id_perpag;
          public               postgres    false    226            �            1259    24607    tb_producto    TABLE     �   CREATE TABLE public.tb_producto (
    id_pr integer NOT NULL,
    id_cat integer,
    nombre_pr text,
    cantidad_pr integer,
    precio_pr double precision,
    foto_pr bytea
);
    DROP TABLE public.tb_producto;
       public         heap r       postgres    false            �            1259    24612    tb_producto_id_pr_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_producto_id_pr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.tb_producto_id_pr_seq;
       public               postgres    false    227            m           0    0    tb_producto_id_pr_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tb_producto_id_pr_seq OWNED BY public.tb_producto.id_pr;
          public               postgres    false    228            �            1259    24613 
   tb_usuario    TABLE     �   CREATE TABLE public.tb_usuario (
    id_us integer NOT NULL,
    id_per integer,
    id_est integer,
    nombre_us text,
    cedula_us text,
    correo_us text,
    clave_us text,
    bloqueo integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.tb_usuario;
       public         heap r       postgres    false            �            1259    24618    tb_usuario_id_us_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_usuario_id_us_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.tb_usuario_id_us_seq;
       public               postgres    false    229            n           0    0    tb_usuario_id_us_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.tb_usuario_id_us_seq OWNED BY public.tb_usuario.id_us;
          public               postgres    false    230            �           2604    24645    tb_auditoria id_aud    DEFAULT     �   ALTER TABLE ONLY auditoria.tb_auditoria ALTER COLUMN id_aud SET DEFAULT nextval('auditoria.tb_auditoria_id_aud_seq'::regclass);
 E   ALTER TABLE auditoria.tb_auditoria ALTER COLUMN id_aud DROP DEFAULT;
    	   auditoria               postgres    false    233    234    234            �           2604    24619    tb_categoria id_cat    DEFAULT     z   ALTER TABLE ONLY public.tb_categoria ALTER COLUMN id_cat SET DEFAULT nextval('public.tb_categoria_id_cat_seq'::regclass);
 B   ALTER TABLE public.tb_categoria ALTER COLUMN id_cat DROP DEFAULT;
       public               postgres    false    219    218            �           2604    24620    tb_estadocivil id_est    DEFAULT     ~   ALTER TABLE ONLY public.tb_estadocivil ALTER COLUMN id_est SET DEFAULT nextval('public.tb_estadocivil_id_est_seq'::regclass);
 D   ALTER TABLE public.tb_estadocivil ALTER COLUMN id_est DROP DEFAULT;
       public               postgres    false    221    220            �           2604    24621    tb_perfilpagina id_perpag    DEFAULT     �   ALTER TABLE ONLY public.tb_perfilpagina ALTER COLUMN id_perpag SET DEFAULT nextval('public.tb_perfilpagina_id_perpag_seq'::regclass);
 H   ALTER TABLE public.tb_perfilpagina ALTER COLUMN id_perpag DROP DEFAULT;
       public               postgres    false    226    225            �           2604    24622    tb_producto id_pr    DEFAULT     v   ALTER TABLE ONLY public.tb_producto ALTER COLUMN id_pr SET DEFAULT nextval('public.tb_producto_id_pr_seq'::regclass);
 @   ALTER TABLE public.tb_producto ALTER COLUMN id_pr DROP DEFAULT;
       public               postgres    false    228    227            �           2604    24623    tb_usuario id_us    DEFAULT     t   ALTER TABLE ONLY public.tb_usuario ALTER COLUMN id_us SET DEFAULT nextval('public.tb_usuario_id_us_seq'::regclass);
 ?   ALTER TABLE public.tb_usuario ALTER COLUMN id_us DROP DEFAULT;
       public               postgres    false    230    229            b          0    24642    tb_auditoria 
   TABLE DATA           �   COPY auditoria.tb_auditoria (id_aud, tabla_aud, operacion_aud, valoranterior_aud, valornuevo_aud, fecha_aud, usuario_aud, esquema_aud, activar_aud, trigger_aud) FROM stdin;
 	   auditoria               postgres    false    234   0<       R          0    24576    tb_categoria 
   TABLE DATA           ?   COPY public.tb_categoria (id_cat, descripcion_cat) FROM stdin;
    public               postgres    false    218   X=       T          0    24582    tb_estadocivil 
   TABLE DATA           A   COPY public.tb_estadocivil (id_est, descripcion_est) FROM stdin;
    public               postgres    false    220   �=       V          0    24588 	   tb_pagina 
   TABLE DATA           F   COPY public.tb_pagina (id_pag, descripcion_pag, path_pag) FROM stdin;
    public               postgres    false    222   >       W          0    24593    tb_parametros 
   TABLE DATA           K   COPY public.tb_parametros (id_par, descripcion_par, valor_par) FROM stdin;
    public               postgres    false    223   �>       X          0    24598 	   tb_perfil 
   TABLE DATA           <   COPY public.tb_perfil (id_per, descripcion_per) FROM stdin;
    public               postgres    false    224   �>       Y          0    24603    tb_perfilpagina 
   TABLE DATA           D   COPY public.tb_perfilpagina (id_perpag, id_per, id_pag) FROM stdin;
    public               postgres    false    225   ?       [          0    24607    tb_producto 
   TABLE DATA           `   COPY public.tb_producto (id_pr, id_cat, nombre_pr, cantidad_pr, precio_pr, foto_pr) FROM stdin;
    public               postgres    false    227   B?       ]          0    24613 
   tb_usuario 
   TABLE DATA           o   COPY public.tb_usuario (id_us, id_per, id_est, nombre_us, cedula_us, correo_us, clave_us, bloqueo) FROM stdin;
    public               postgres    false    229   ?@       o           0    0    tb_auditoria_id_aud_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('auditoria.tb_auditoria_id_aud_seq', 13, true);
       	   auditoria               postgres    false    233            p           0    0    tb_categoria_id_cat_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.tb_categoria_id_cat_seq', 5, true);
          public               postgres    false    219            q           0    0    tb_estadocivil_id_est_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.tb_estadocivil_id_est_seq', 7, true);
          public               postgres    false    221            r           0    0    tb_pagina_id_pag_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tb_pagina_id_pag_seq', 5, true);
          public               postgres    false    231            s           0    0    tb_perfil_id_per_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tb_perfil_id_per_seq', 3, true);
          public               postgres    false    232            t           0    0    tb_perfilpagina_id_perpag_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tb_perfilpagina_id_perpag_seq', 7, true);
          public               postgres    false    226            u           0    0    tb_producto_id_pr_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tb_producto_id_pr_seq', 10, true);
          public               postgres    false    228            v           0    0    tb_usuario_id_us_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tb_usuario_id_us_seq', 15, true);
          public               postgres    false    230            b     x����j�0Fg�)�����:��N]ҩ[�\ۊ"�XF���Wv(�m��8:��,��g^*c5$����C��j��R>��y�M�����bd{P��*���ָ�M���x���-ǿL�5�Py�� VG�b&|7��H��Y�&�AwEA�Ny���VФ7�++%���tɆF�+\����5X��D�,`"r�i�.c�.f�F	�8�=tZӡ���.X���N��L�R� ����s"vP���ƠZ��5e!y���6؄0NWTxܥi����	      R   I   x�3�tN��,N-I,�2�H�+I���K-�2�.MILI-J�pF%$�d�� 9����ɩ��E���\1z\\\ �8r      T   C   x�3���)I-��O�2�tN,NL1�9]2��3!\ΰ�R0�������I-�9D%W� 1��      V   �   x���A�0E��)8Ԅ��^�ĸs3�&����o��p��{���3*Uc�<-�A̤��f
0O$:�M�:A�Mӹ��$ۙ����\�eF*�˅�_��4nA����r�h.����=w,['�#FoQ�����JF�����o~�lx      W      x������ � �      X   0   x�3�tL����,.)JL�/�2�t��L�+I�2�K�KI	��qqq &��      Y   .   x���  �wn���a�9�ǒK���f���p4G��F����      [   �   x�U��n�0�珧� �@��d��!P�*�.q��ȆH���L�J�n����NB�]�'�;+v4-���֐�	2�lҦ�鐔(�A��
��wdy��)��P�3+Txs�[KSG��y��F����=��Q�n���*�,(�Wd�h�����b�1�w��ҵ�A���Aݹ`vș=�aϑcGW�L�xc�~�':�&Z�)�=ٙ��q�����6��w�ŭ��S�$�7ڊ[�      ]   S  x����n� ������Ϯ�6�t���H+��>}�:��n��8�#0��ӃA�0��B4 ��}0��)�?C�ݜc�@Ȃ�LfgWxj�_z���[�X�
) �.��k��N��VeE��钥��|���V�������Z�3C�þf>��`E��͐H�%_�q���"��9��O�H�o����h����3N�����7�$��]3y�y2m(g�c��hX75�;(�c���	����a)O^� �'
�?]}�q���Q� �yNO�B�U8(D�	���u�F<9�^��>�`:m��Bk����Q��a�+~��ݏz+���?�@��ȳ,��T��     