Import-Module VMware.VimAutomation.Core

$referencedAssemblies = "C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Core\VMware.Vim.dll",
			"C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Sdk\VMware.VimAutomation.Sdk.Impl.dll",
			"C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Sdk\VMware.VimAutomation.Sdk.Types.dll",
			"C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Sdk\VMware.VimAutomation.Sdk.Interop.dll",
			"C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Sdk\VMware.VimAutomation.Sdk.Util10.dll",
			"C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Core\VMware.VimAutomation.ViCore.Impl.dll",
			"C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Core\VMware.VimAutomation.ViCore.Interop.dll",
			"C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\VMware.VimAutomation.Core\VMware.VimAutomation.ViCore.Types.dll"
#Use Command to Generate info (gotta add methods) maybe static?
#$Test = Get-VMhost | select -first 1 | Get-Member | Where-Object MemberType -eq Property | ForEach-Object { 
# 	 Write-Output "public $($_.Definition.replace({get;},{ get; set; }) -replace `"System.Nullable[.*]`",`"$($_.Name)?`")"}


Add-Type -ReferencedAssemblies $referencedAssemblies -Verbose -TypeDefinition @("
	using VMware.VimAutomation.ViCore.Interop;
	using VMware.VimAutomation.ViCore.Types.V1;
	using VMware.VimAutomation.ViCore.Types.V1.Host;
	using VMware.VimAutomation.ViCore.Types.V1.Host.Networking;
	using VMware.VimAutomation.ViCore.Types.V1.Host.Storage;
	using VMware.VimAutomation.ViCore.Types.V1.Inventory;
	using VMware.VimAutomation.ViCore.Impl.V1;
	using VMware.VimAutomation.ViCore.Impl.V1.Inventory;
	using VMware.VimAutomation.Sdk.Impl;
	using VMware.VimAutomation.Sdk.Interop;
	using VMware.VimAutomation.Sdk.Types;
	using VMware.VimAutomation.Sdk.Util10;
	using VMHost = VMware.VimAutomation.ViCore.Types.V1.Inventory.VMHost;
	using ConnectionState = VMware.VimAutomation.ViCore.Types.V1.Host.VMHostState;
	using State = VMware.VimAutomation.ViCore.Types.V1.Host.VMHostState;
	using TimeZone = VMware.VimAutomation.ViCore.Types.V1.Host.VMHostTimeZone;
	using Parent = VMware.VimAutomation.ViCore.Types.V1.Inventory.InventoryItem;
	using PowerState = VMware.VimAutomation.ViCore.Types.V1.Host.VMHostPowerState;
	using VMSwapfileDatastore =  VMware.VimAutomation.ViCore.Types.V1.DatastoreManagement.Datastore;
	using StorageInfo = VMware.VimAutomation.ViCore.Types.V1.Host.Storage.VMHostStorageInfo;
	using NetworkInfo = VMware.VimAutomation.ViCore.Types.V1.Host.Networking.VMHostNetworkInfo;
	using DiagnosticPartition = VMware.VimAutomation.ViCore.Types.V1.Host.VMHostDiagnosticPartition;
	using FirewallDefaultPolicy = VMware.VimAutomation.ViCore.Types.V1.Host.VMHostFirewallDefaultPolicy;

	namespace MockVMHost {
		public class MockVMHostObject {
			public static object Testing { get { return 1; }}
		}
		public class MockVMHost : VMHost {
			public bool HyperthreadingActive { get; set; }
			public bool IsStandalone { get; set; }
			public decimal MemoryTotalGB { get; set; }
			public decimal MemoryTotalMB { get; set; }
			public decimal MemoryUsageGB { get; set; }
			public decimal MemoryUsageMB { get; set; }
			public int CpuTotalMhz { get; set; }
			public int CpuUsageMhz { get; set; }
			public int NumCpu { get; set; }
			public string ApiVersion { get; set; }
			public string Build { get; set; }
			public string Id { get; set; }
			public string LicenseKey { get; set; }
			public string Manufacturer { get; set; }
			public string MaxEVCMode { get; set; }
			public string Model { get; set; }
			public string Name { get; set; }
			public string ParentId { get; set; }
			public string ProcessorType { get; set; }
			public string Uid { get; set; }
			public string Version { get; set; }
			public string[] DatastoreIdList { get; set; }
			public State State { get; set; }
			public PowerState PowerState { get; set; }
			public VMSwapfilePolicy? VMSwapfilePolicy { get; set; }
			public TimeZone TimeZone { get; set; }
			public Parent Parent { get; set; }
			public VMSwapfileDatastore VMSwapfileDatastore { get; set; }
			public StorageInfo StorageInfo { get; set; }
			public NetworkInfo NetworkInfo { get; set; }
			public DiagnosticPartition DiagnosticPartition { get; set; }
			public FirewallDefaultPolicy FirewallDefaultPolicy { get; set; }
			public ConnectionState ConnectionState { get; set; }
			public string VMSwapfileDatastoreId { get; set; }
			object ExtensionData.ExtensionData { get { return MockVMHostObject.Testing; } }
			public void LockUpdates(){}
			public void UnlockUpdates(){}
		}
	}
")

$MockVMHost = New-Object MockVMHost.MockVMHost
$MockVMHost -is [VMware.VimAutomation.ViCore.Types.V1.Inventory.VMHost]
$MockVMHost.GetType()

$MockVMHost.Name = 'TestVMHostName'
$MockVMHost
