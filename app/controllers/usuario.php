<?php
require_once '../../Config.inc.php';
require_once '../../app/models/usuario.php';
require_once '../../app/models/material.php';
require_once '../../configuration/Funciones.php';
require_once '../../configuration/Sesion.php';

function handler()
{
    if (!empty($_GET['event']))
    {
        switch ($_GET['event'])
        {
            case 'registrar': 
                if (!empty($_POST))
                {
                    $objUsuario = new Usuario();
                    $objUsuario->setApellido($_POST['apellido']);
                    $objUsuario->setClave(trim($_POST['clave']));
                    $objUsuario->setCodigo(trim($_POST['codigo']));
                    $objUsuario->setDni(trim($_POST['dni']));
                    $objUsuario->setEmail(trim($_POST['email']));
                    $objUsuario->setFecha_nacimiento($_POST['fecha_nacimiento']);
                    $objUsuario->setId_sede($_POST['id_sede']);
                    $objUsuario->setId_tipo_usuario($_POST['id_tipo_usuario']);
                    $objUsuario->setNombre(trim($_POST['nombre']));
                    $objUsuario->setTelefono(trim($_POST['telefono']));
                    //die(var_dump($objUsuario->registrarUsuario()));
                    if ($objUsuario->registrarUsuario())
                    {
                        header("Location: ../../site/panel/registro.php?msj=".Funciones::encodeStrings('ok',2));
                        #header("Location: ../../site/panel/index.php");
                    }else
                    {
                        header("Location: ../../site/panel/registro.php?msj=".Funciones::encodeStrings('no',2));
                        #header("Location: ../../site/panel/index.php");
                    }
                }else
                {
                    #header("Location: ../../site/panel/mensaje_registro.php?msj=".Funciones::encodeStrings('no'));
                    header("Location: ../../site/panel/");
                }                
                break;
            case 'registrar_adm': 
                if (!empty($_POST))
                {
                    $objUsuario = new Usuario();
                    $objUsuario->setApellido($_POST['apellido']);
                    $objUsuario->setClave($_POST['clave']);
                    $objUsuario->setCodigo($_POST['codigo']);
                    $objUsuario->setDni($_POST['dni']);
                    $objUsuario->setEmail($_POST['email']);
                    $objUsuario->setFecha_nacimiento($_POST['fecha_nacimiento']);
                    $objUsuario->setId_sede($_POST['id_sede']);
                    $objUsuario->setId_tipo_usuario($_POST['id_tipo_usuario']);
                    $objUsuario->setNombre($_POST['nombre']);
                    $objUsuario->setTelefono($_POST['telefono']);
                    //die(var_dump($objUsuario->registrarUsuario()));
                    if ($objUsuario->registrarUsuario())
                    {
                        header("Location: ../../site/panel/administracion/registrar_usuario.php?msj=".Funciones::encodeStrings('ok',2));
                        #header("Location: ../../site/panel/index.php");
                    }else
                    {
                        header("Location: ../../site/panel/administracion/registrar_usuario.php?msj=".Funciones::encodeStrings('no',2));
                        #header("Location: ../../site/panel/index.php");
                    }
                }else
                {
                    #header("Location: ../../site/panel/mensaje_registro.php?msj=".Funciones::encodeStrings('no'));
                    header("Location: ../../site/panel/index.php");
                }                
                break;
            case 'actualizar_usu':
                if (!empty($_POST))
                {
                    $objUsuario = new Usuario();
                    $objUsuario->setId(base64_decode($_POST['id']));
                    $objUsuario->setApellido($_POST['apellido']);
                    $objUsuario->setCodigo($_POST['codigo']);
                    $objUsuario->setDni($_POST['dni']);
                    $objUsuario->setEmail($_POST['email']);
                    $objUsuario->setFecha_nacimiento($_POST['fecha_nacimiento']);
                    $objUsuario->setId_sede($_POST['id_sede']);
                    $objUsuario->setId_tipo_usuario($_POST['id_tipo_usuario']);
                    $objUsuario->setNombre($_POST['nombre']);
                    $objUsuario->setTelefono($_POST['telefono']);
                    //die(var_dump($objUsuario->registrarUsuario()));
                    if ($objUsuario->actualizarUsuario())
                    {
                        header("Location: ../../site/panel/pages/user_update.php?id=".$_POST['id']."&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        header("Location: ../../site/panel/pages/user_update.php?id=".$_POST['id']."&msj=".Funciones::encodeStrings('no',2));
                    }
                }else
                {                   
                    header("Location: ../../site/panel/index.php");
                }
                break;
                case 'actualizar_adm':
                if (!empty($_POST))
                {
                    $objUsuario = new Usuario();
                    $objUsuario->setId(base64_decode($_POST['id']));
                    $objUsuario->setApellido($_POST['apellido']);
                    $objUsuario->setCodigo($_POST['codigo']);
                    $objUsuario->setDni($_POST['dni']);
                    $objUsuario->setEmail($_POST['email']);
                    $objUsuario->setFecha_nacimiento($_POST['fecha_nacimiento']);
                    $objUsuario->setId_sede($_POST['id_sede']);
                    $objUsuario->setId_tipo_usuario($_POST['id_tipo_usuario']);
                    $objUsuario->setNombre($_POST['nombre']);
                    $objUsuario->setTelefono($_POST['telefono']);
                    //die(var_dump($objUsuario->registrarUsuario()));
                    if ($objUsuario->actualizarUsuario())
                    {
                        header("Location: ../../site/panel/administracion/form_actualizar_adm.php?id=".$_POST['id']."&msj=".Funciones::encodeStrings('ok',2));
                    }else
                    {
                        header("Location: ../../site/panel/administracion/form_actualizar_adm.php?id=".$_POST['id']."&msj=".Funciones::encodeStrings('no',2));
                    }
                }else
                {                   
                    header("Location: ../../site/panel/index.php");
                }
                break;
            case 'buscar_rec':
                break;
            case 'modificar':
                break;
            case 'listar':
                break;
            case 'deshabilitar':
                $objUsuario = new Usuario();
                $objUsuario->setId(base64_decode(($_GET['id'])));
                if ($objUsuario->deshabilitarUsuario())
                {
                    header("Location: ../../site/panel/administracion/ver_usuarios.php");
                }else
                {
                    header("Location: ../../site/panel/administracion/ver_usuarios.php");
                }
                break;
            case 'habilitar':
                $objUsuario = new Usuario();
                $objUsuario->setId(base64_decode(($_GET['id'])));
                if ($objUsuario->habilitarUsuario())
                {
                    header("Location: ../../site/panel/administracion/ver_usuarios.php");
                }else
                {
                    header("Location: ../../site/panel/administracion/ver_usuarios.php");
                }
                break;
            
        }
    }
}

handler();