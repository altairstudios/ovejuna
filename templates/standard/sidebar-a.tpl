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
	jQuery("#query").typeahead({
		source: function() {
			var results; 
			
			jQuery.ajax({
				async: false,
				data: {
					query: jQuery("#query").val()
				},
				success: function(data) {
					results = data;
				},
				type: "GET",
				url: "managesearch.php?action=autocomplete",
				dataType: "json"
			});
			
			return results;
		}
	});
</script>
{/literal}


<div id="content-right">



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