<?php

require_once '../Config.inc.php';
require_once '../app/models/usuario.php';
require_once '../configuration/Funciones.php';
require_once '../configuration/Sesion.php';

function handler ()
{
    global $config;
    session_start();
    if (empty($_SESSION))
    {
        if (empty($_POST))
        {
            header("Location: ../");
        }else
        {
            $objUsuario = new Usuario();
            $objUsuario->setNombre($_POST['username']);
            $objUsuario->setClave($_POST['password']);
            if ($objUsuario->inicioSesion())
            {
                header("Location: ../site/panel/");         
                
            }else
            {
                header("Location: ../index.php?msj=".Funciones::encodeStrings('Usuario o contraseña incorrectos', 2));
            }
        }
    }else // si es que hay una sesion activa
    {
        if (empty($_GET['event']))
        {
            header("Location: ../");
        }else
        {
            if (Funciones::decodeStrings($_GET['event'],2) == 'off') {
                       
                $objUsuario = new Usuario();
                if ($objUsuario->cerrarSesion())
                {
                    header("Location: ../");
                }else
                {
                    header("Location: ../site/panel/");
                }
            }
        }
    }
}

handler();