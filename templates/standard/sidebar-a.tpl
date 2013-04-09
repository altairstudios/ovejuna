<div class="well">
	<div>
		<form method="get" action="managesearch.php">
			<div class="input-append">
				<input class="span12" id="query" name="query" type="text" autocomplete="off" />
				<button class="btn" type="submit">{#gosearch#}</button>
			</div>
			<input type="hidden" name="action" value="search" />
		</form>
	</div>
</div>

{literal}
<script type="text/javascript">
	var typeaheadSources = [];

	jQuery("#query").typeahead({
		source: function() {
			jQuery.ajax({
				async: false,
				data: {
					query: jQuery("#query").val()
				},
				success: function(data) {
					typeaheadSources = data;
				},
				type: "GET",
				url: "managesearch.php?action=autocomplete"
			});
			console.log(typeaheadSources);
			return typeaheadSources;
		},
		updater: function() {
			console.log(arguments);
		}
	});



/* new Ajax.Autocompleter('query', 'choices', 'managesearch.php?action=ajaxsearch', {paramName:'query',minChars: 2,indicator: 'indicator1'});
var on = new Ajax.PeriodicalUpdater("onlinelist","manageuser.php?action=onlinelist",{method:'get',evalScripts:true,frequency:35,decay:1.5});
*/

</script>
{/literal}


<div id="content-right">


	


	{*Calendar*}
	{* theCal.dayNames = ["{#monday#}","{#tuesday#}","{#wednesday#}","{#thursday#}","{#friday#}","{#saturday#}","{#sunday#}"];
	<div class="content-right-in">
		<h2><a id="mycaltoggle" class="win-up" href="javascript:blindtoggle('mycal_mini');toggleClass('mycaltoggle','win-up','win-down');">{#calendar#}</a></h2>
		<div id = "mycal_mini"></div>
		<script type = "text/javascript">
		theCal = new calendar({$theM},{$theY});
		theCal.dayNames = ["{#monday#}","{#tuesday#}","{#wednesday#}","{#thursday#}","{#friday#}","{#saturday#}","{#sunday#}"];
		theCal.monthNames = ["{#january#}","{#february#}","{#march#}","{#april#}","{#may#}","{#june#}","{#july#}","{#august#}","{#september#}","{#october#}","{#november#}","{#december#}"];
		theCal.getCal('mycal_mini');
		</script>
	</div>
	Calendar End*}


	{*Tag Cloud*}
	{if $showcloud == "1"}
		{if $cloud != ""}
		<div class="content-right-in">
			<h2><a id="tagcloudtoggle" class="win-up" href="javascript:blindtoggle('tagcloud');toggleClass('tagcloudtoggle','win-up','win-down');">{#tags#}</a></h2>
			<div id = "tagcloud" class="cloud">
				{$cloud}
			</div>
		</div>
		{/if}
	{/if}
	{*Tag Cloud End*}

	{*Quickfinder*}
	{if $openProjects[0].ID > 0}
		<div class="content-right-in">
			<h2><a id="quickfindertoggle" class="win-up" href="javascript:blindtoggle('quickfinder');toggleClass('quickfindertoggle','win-up','win-down');">{#myprojects#}</a></h2>
			<div id = "quickfinder">
				<form>
					<select style="background-color:#CCC;width:100%;" onchange="window.location='manageproject.php?action=showproject&id='+this.value;">
						<option>{#chooseone#}</option>
						{section name=drop loop=$openProjects}
							<option value="{$openProjects[drop].ID}">{$openProjects[drop].name|truncate:40:"...":true}</option>
						{/section}
					</select>
				</form>
			</div>
		</div>
	{/if}

	{*Onlinelist*}
	<div class="content-right-in">
			<h2><a id="onlinelisttoggle" class="win-up" href="javascript:blindtoggle('onlinelist');toggleClass('onlinelisttoggle','win-up','win-down');">{#usersonline#}</a></h2>

			<div id="onlinelist">
				{$cloud}
			</div>
	</div>


		{literal}
			  <script type = "text/javascript">
			 /* new Ajax.Autocompleter('query', 'choices', 'managesearch.php?action=ajaxsearch', {paramName:'query',minChars: 2,indicator: 'indicator1'});
				 var on = new Ajax.PeriodicalUpdater("onlinelist","manageuser.php?action=onlinelist",{method:'get',evalScripts:true,frequency:35,decay:1.5});
*/

			</script>
		{/literal}

</div>