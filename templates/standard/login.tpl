{include file="components/header.tpl" title="Login" showheader="no" jsload = "ajax"}
<div class="container">
	<div class="row">
		<div class="span4 offset4">
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
		<div class="span6 offset3">
			{if $loginerror == 1}
				<div class="alert alert-error">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<p>{#loginerror#}</p>
					{if $mailnotify == 1}
						<p><a class="btn btn-danger" href="manageuser.php?action=loginerror">{#resetpassword#}</a></p>
					{/if}
				</div>
			{/if}
		</div>
	</div>
</div>
{include file="components/footer.tpl"}