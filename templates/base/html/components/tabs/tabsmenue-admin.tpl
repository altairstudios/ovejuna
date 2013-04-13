			<div class="navbar">
				<div class="navbar-inner">	
					<ul class="nav">
						<li {if $projecttab == "active" }class="active"{/if}>
							<a href="admin.php?action=projects">{#projectadministration#}</a>
						</li>
						<li {if $usertab == "active" }class="active"{/if}>
							<a href="admin.php?action=users">{#useradministration#}</a>
						</li>
						<li {if $settingstab == "active" }class="active"{/if}>
							<a href="admin.php?action=system">{#systemadministration#}</a>
						</li>
					</ul>	
				</div>
			</div>