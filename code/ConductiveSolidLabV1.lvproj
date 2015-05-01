<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="14008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="ConductiveSolidLabV1.vi" Type="VI" URL="../ConductiveSolidLabV1.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
			</Item>
			<Item Name="ChartTuple.vi" Type="VI" URL="../SubVi/ChartTuple.vi"/>
			<Item Name="GpibQuery.vi" Type="VI" URL="../SubVi/GpibQuery.vi"/>
			<Item Name="Keithley3Fres.vi" Type="VI" URL="../SubVi/Keithley3Fres.vi"/>
			<Item Name="setTempCommand.vi" Type="VI" URL="../SubVi/setTempCommand.vi"/>
		</Item>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="ConductiveSolidLabV1" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{3935973A-25DD-435E-94A5-4E949AED19CC}</Property>
				<Property Name="App_INI_GUID" Type="Str">{5A74CE29-1A8D-4C4A-865A-5847EEE99FD2}</Property>
				<Property Name="App_serverConfig.httpPort" Type="Int">8002</Property>
				<Property Name="Bld_autoIncrement" Type="Bool">true</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{493D9141-A567-407D-8886-659D5D473FB0}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">ConductiveSolidLabV1</Property>
				<Property Name="Bld_excludeInlineSubVIs" Type="Bool">true</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/NI_AB_PROJECTNAME/ConductiveSolidLabV1</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{C2F64DE0-11A1-4FEC-8F15-F6CDFDA91721}</Property>
				<Property Name="Bld_version.build" Type="Int">1</Property>
				<Property Name="Bld_version.major" Type="Int">1</Property>
				<Property Name="Destination[0].destName" Type="Str">ConductiveSolidLabV1.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/ConductiveSolidLabV1/ConductiveSolidLabV1.exe</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/ConductiveSolidLabV1/data</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Source[0].itemID" Type="Str">{7A6385E4-9CDC-4B8B-8BAB-798ABB485E8C}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/ConductiveSolidLabV1.vi</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="SourceCount" Type="Int">2</Property>
				<Property Name="TgtF_fileDescription" Type="Str">ConductiveSolidLabV1</Property>
				<Property Name="TgtF_internalName" Type="Str">ConductiveSolidLabV1</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">Copyright © 2015 </Property>
				<Property Name="TgtF_productName" Type="Str">ConductiveSolidLabV1</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{BBEF23C9-F0CB-4C99-A10A-18C02B98A2FC}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">ConductiveSolidLabV1.exe</Property>
			</Item>
		</Item>
	</Item>
</Project>
