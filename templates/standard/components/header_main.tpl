		<div class="navbar navbar-static-top">
			<div class="navbar-inner">
				<div class="container-fluid">
					<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</a>
					<a class="brand" href="index.php">{$settings.name} {if $settings.subtitle}{$settings.subtitle}{/if}</a> 
				
					{if $loggedin == 1}
						<div class="nav-collapse collapse">
							<ul class="nav" role="navigation">
								<li>
									<a href="index.php" role="button">{#desktop#}</a>
								</li>
								<li>
									<a href="manageuser.php?action=profile&amp;id={$userid}" role="button">{#myaccount#}</a>
								</li>
								{if $userpermissions.admin.add}
								<li class="dropdown">
									<a href="#" id="drop-admin" role="button" class="dropdown-toggle" data-toggle="dropdown">{#administration#} <b class="caret"></b></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="drop-admin">
										<li role="presentation"><a role="menuitem" href="admin.php?action=projects">{#projectadministration#}</a></li>
										<li role="presentation"><a role="menuitem" href="admin.php?action=users">{#useradministration#}</a></li>
										<li role="presentation"><a role="menuitem" href="admin.php?action=system">{#systemadministration#}</a></li>
									</ul>
								</li>
								{/if}
							</ul>
							<ul class="nav pull-right">
								<li>
									<a href="manageuser.php?action=logout">{#logout#}</a>
								</li>
							</ul>
						</div>
					{/if}
				</div>
			</div>
		</div>