<?php
ini_set("arg_separator.output", "&amp;");
ini_set('default_charset', 'utf-8');
// Start output buffering with gzip compression and start the session
ob_start('ob_gzhandler');
session_start();
// get full path to collabtive
define("CL_ROOT", realpath(dirname(__FILE__)) . '/../');
define("OV_ROOT", realpath(dirname(__FILE__)));

// configuration to load
define("CL_CONFIG", "standard");
// collabtive version and release date
define("CL_VERSION", 1.0);
define("CL_PUBDATE","1365026400");
// uncomment for debugging
//error_reporting(E_ALL | E_STRICT);
// include config file , pagination and global functions

require(CL_ROOT . "/config/" . CL_CONFIG . "/config.php");


require(OV_ROOT . '/smarty/Smarty.class.php');
require(CL_ROOT . "/include/SmartyPaginate.class.php");


// Autoload requires classes on new class()
function cl_autoload($class_name)
{
	$pfad = CL_ROOT . "/include/class." . $class_name . ".php";
    if (file_exists($pfad)) {
        require_once($pfad);
	} else if(file_exists(CL_ROOT . "/core/" . $class_name . ".class.php")) {
		require_once(CL_ROOT . "/core/" . $class_name . ".class.php");
	} else if(file_exists(CL_ROOT . "/core/" . $class_name . ".php")) {
		require_once(CL_ROOT . "/core/" . $class_name . ".php");
    } else {
        die("<b>Fatal Error. Class $class_name could not be located.</b>");
    }
}
spl_autoload_register('cl_autoload');

function chkproject($user, $project)
{
	global $conn;
    $user = (int) $user;
    $project = (int) $project;
    $chk = @$conn->query("SELECT ID FROM projekte_assigned WHERE projekt = $project AND user = $user")->fetch();

    $chk = $chk[0];

    if ($chk != "") {
        return true;
    } else {
        return false;
    }
}

function getAvailableLanguages()
{
    $dir = scandir(CL_ROOT . "/language/");
    $languages = array();
    if (!empty($dir)) {
        foreach($dir as $folder) {
            if ($folder != "." and $folder != "..") {
                array_push($languages, $folder);
            }
        }
    }
    if (!empty($languages)) {
        return $languages;
    } else {
        return false;
    }
}

function countLanguageStrings($locale)
{
    if (file_exists(CL_ROOT . "/language/$locale/lng.conf")) {
        $langfile = file("./language/$locale/lng.conf");
        $cou1 = (int) 0;
        $cou2 = (int) 0;
    }

    if (!empty($langfile)) {
        foreach($langfile as $lang) {
            if (strstr($lang, "=")) {
                $cou1 = $cou1 + 1;
                $slang = explode("=", $lang);
                if (trim($slang[1]) != "") {
                    $cou2 = $cou2 + 1;
                }
            }
        }
    }

    if ($cou1 > 0 and $cou2 > 0) {
        $proz = $cou2 / $cou1 * 100;
        return floor($proz);
    } else {
        return 0;
    }
}

function readLangfile($locale)
{
    $langfile = file("./language/$locale/lng.conf");
    $langkeys = array();
    $langvalues = array();
    foreach($langfile as $lang) {
        if (strstr($lang, "=")) {
            $slang = explode("=", $lang);
            array_push($langkeys, trim($slang[0]));
            array_push($langvalues, trim($slang[1]));
        }
    }
    $langfile = array_combine($langkeys, $langvalues);
    if (!empty($langfile)) {
        return $langfile;
    } else {
        return false;
    }
}

function detectSSL()
{
    if (getArrayVal($_SERVER, "https") == "on") {
        return true;
    } elseif (getArrayVal($_SERVER, "https") == 1) {
        return true;
    } elseif (getArrayVal($_SERVER, "SERVER_PORT") == 443) {
        return true;
    } else {
        return false;
    }
}

function getMyUrl()
{
    if (isset($_SERVER['REQUEST_URI']) && !empty($_SERVER['REQUEST_URI'])) {
        $requri = $_SERVER['REQUEST_URI'];
    } else {
        // assume IIS
        $requri = $_SERVER['SCRIPT_NAME'];
        if (isset($_SERVER['QUERY_STRING']) && !empty($_SERVER['QUERY_STRING'])) {
            $requri .= '?' . $_SERVER['QUERY_STRING'];
        }
    }
    $host = $_SERVER['HTTP_HOST'];
    $pos1 = strrpos($requri, "/");
    $requri = substr($requri, 0, $pos1 + 1);
    if (detectSSL()) {
        $host = "https://" . $host;
    } else {
        $host = "http://" . $host;
    }
    $url = $host . $requri;

    return $url;
}

function strip_only_tags($str, $tags, $stripContent = false)
{
    $content = '';
    if (!is_array($tags)) {
        $tags = (strpos($str, '>') !== false ? explode('>', str_replace('<', '', $tags)) : array($tags));
        if (end($tags) == '') array_pop($tags);
    }
    foreach($tags as $tag) {
        if ($stripContent)
            $content = '(.+</' . $tag . '(>|\s[^>]*>)|)';
        $str = preg_replace('#</?' . $tag . '(>|\s[^>]*>)' . $content . '#is', '', $str);
    }
    return $str;
}

function getArrayVal(array $array, $name)
{
    if (array_key_exists($name, $array)) {
        return strip_only_tags($array[$name], "script");
    } else {
        return false;
    }
}

function delete_directory($dirname)
{
    if (is_dir($dirname)) {
        $dir_handle = opendir($dirname);
    }
    if (!$dir_handle) {
        return false;
    } while ($file = readdir($dir_handle)) {
        if ($file != "." && $file != "..") {
            if (!is_dir($dirname . "/" . $file)) {
                unlink($dirname . "/" . $file);
            } else {
                delete_directory($dirname . '/' . $file);
            }
        }
    }
    closedir($dir_handle);
    rmdir($dirname);
    return true;
}

function reduceArray(array $arr)
{
    $num = count($arr);
    $earr = array();
    for($i = 0;$i < $num;$i++) {
        if (!empty($arr[$i])) {
            $earr = array_merge($earr, $arr[$i]);
        }
    }
    return $earr;
}

function getUpdateNotify(){
	return json_decode(@file_get_contents("http://collabtive.o-dyn.de/update/chk.php"));
}



// Start database connection

if (!empty($db_name) and !empty($db_user))
{
	$conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
    //$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
}
// Start template engine
$template = new Smarty();
// get the available languages
$languages = getAvailableLanguages();
// get URL to collabtive
$url = getMyUrl();
$template->assign("url", $url);
$template->assign("languages", $languages);
$template->assign("myversion", "0.1");
$template->assign("cl_config", CL_CONFIG);
// Assign globals to all templates
if (isset($_SESSION["userid"]))
{
    // unique ID of the user
    $userid = $_SESSION["userid"];
    // name of the user
    $username = $_SESSION["username"];
    // timestamp of last login
    $lastlogin = $_SESSION["lastlogin"];
    // selected locale
    $locale = $_SESSION["userlocale"];
    // gender
    $gender = $_SESSION["usergender"];
    // what the user may or may not do
    $userpermissions = $_SESSION["userpermissions"];
    // assign it all to the templates
    $template->assign("userid", $userid);
    $template->assign("username", $username);
    $template->assign("lastlogin", $lastlogin);
    $template->assign("usergender", $gender);
    $template->assign("userpermissions", $userpermissions);
    $template->assign("loggedin", 1);
}
else
{
    $template->assign("loggedin", 0);
}
// get system settings
if (isset($conn))
{
    $set = (object) new settings();
    $settings = $set->getSettings();

    define("CL_DATEFORMAT", $settings["dateformat"]);

    date_default_timezone_set($settings["timezone"]);
    $template->assign("settings", $settings);
}
// Set Template directory
// If no directory is set in the system settings, default to the standard theme
if (isset($settings['template']))
{
    $template->template_dir = CL_ROOT . "/templates/$settings[template]/";
    $template->tname = $settings["template"];
}
else
{
    $template->template_dir = CL_ROOT . "/templates/standard/";
    $template->tname = "standard";
}

//HACK dinamic
$template->template_dir = CL_ROOT . "/templates/base/html/";

if (!isset($locale))
{
    if (isset($settings["locale"]))
    {
        $locale = $settings['locale'];
    }
    else
    {
        $locale = "en";
    }
    $_SESSION['userlocale'] = $locale;
}
// if detected locale doesnt have a corresponding langfile , use system default locale
// if, for whatever reason, no system default language is set, default to english as a last resort
if (!file_exists(CL_ROOT . "/language/$locale/lng.conf"))
{
    $locale = $settings['locale'];
    $_SESSION['userlocale'] = $locale;
}
// Set locale directory
$template->config_dir = CL_ROOT . "/language/$locale/";
// read language file into PHP array
$langfile = readLangfile($locale);

$template->assign("langfile", $langfile);
$template->assign("locale", $locale);
// css classes for headmenue
// this indicates which of the 3 main stages the user is on
$mainclasses = array("desktop" => "desktop",
    "profil" => "profil",
    "admin" => "admin"
    );
$template->assign("mainclasses", $mainclasses);
$they = date("Y");
$them = date("n");
$template->assign("theM", $them);
$template->assign("theY", $they);
// Get the user's projects for the quickfinder in the sidebar
if (isset($userid))
{
	$project = new project();
	$myOpenProjects = $project->getMyProjects($userid);
	$template->assign("openProjects", $myOpenProjects);
}

// clear session data for pagination
SmartyPaginate::disconnect();

