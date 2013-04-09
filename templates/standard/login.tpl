{include file="components/header.tpl" title="Login" showheader="no" jsload = "ajax"}

<div class="container">
	{if $loginerror == 1}
		<div class="alert alert-error">
			<p>{#loginerror#}</p>
			{if $mailnotify == 1}
				<p><a href="manageuser.php?action=loginerror">{#resetpassword#}</a></p>
				<form id = "blaform" name = "resetform" class = "main" method="post" action="" >
							<div class="row" style="text-align:center;">
								<button  style = "float:none;margin:0 0 0 0;" onclick="$('blaform').submit();" onfocus="this.blur();"></button>
							</div>
						</form>
			{/if}
		</div>
	{/if}
	<form action="manageuser.php?action=login" class="form-signin" method="post">
		<fieldset>
			<img src="templates/base/img/logo.png" alt="Ovejuna" title="Ovejuna project managements" />
			<h2 class="form-signin-heading">Please sign in</h2>
			<input class="input-block-level" type="text" name="username" placeholder="{#name#}" />
			<input class="input-block-level" name="pass" placeholder="{#password#}" type="password" />
			<button class="btn btn-large btn-primary" type="submit">{#loginbutton#}</button>
		</fieldset>
	</form>
</div>
{include file="footer.tpl"}