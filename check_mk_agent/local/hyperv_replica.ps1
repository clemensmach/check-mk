# Hyper V Replica Status Monitoring
# Version 1.0.0
Write-Host "0 HyperVReplica-Version - 1.0.0"


# TODO - fix error if VM has whitespaces in name
# TODO - implement performance data (Measure-VMReplicaiton)
# TODO - implement all health states



#Get-VMReplication -ReplicationMode Primary


Try {
    $vmlist = Get-VM
    If ($vmlist.count -gt 0) {
        Foreach($VM in $vmlist) {  

            switch ($VM.ReplicationHealth) {
                "Normal" { Write-Host "0 HyperVReplica-$($VM.Name) syncsize=0 Sync OK State: $($VM.ReplicationState)  Health: $($VM.ReplicationHealth)" }
                "Warning" { Write-Host "1 HyperVReplica-$($VM.Name) syncsize=0 State: $($VM.ReplicationState)  Health: $($VM.ReplicationHealth)" }
                "Critical" { Write-Host "2 HyperVReplica-$($VM.Name) syncsize=0 State: $($VM.ReplicationState)  Health: $($VM.ReplicationHealth)" }
                "NotApplicable" { Write-Host "0 HyperVReplica-$($VM.Name) syncsize=0 no replica" }
                # ReplicationState
                #"FailOverWaitingCompletion" {This state indicates that the failover is still in progress.}
                #"FailedOver" {This state indicates that the virtual machine failover is completed.}
                #"ReadyForInitialReplication": This replication state is shown for the virtual machines for which Hyper-V replication is enabled but the initial replication has not been completed yet. This replication state is always shown on the Primary Server or for a Primary Virtual Machine.
                #Replicating: The virtual machine is replicating normally.
                #Resynchronizing: The resynchronization event has been triggered automatically or by an administrator.
                #ResynchronizeSuspended: The resynchronization process is paused.
                #Suspended: Virtual machine is suspended. In other words, the replication is paused.
                #SyncedReplicationComplete: Resynchronization has been completed successfully for the virtual machine.
                #WaitingForInitialReplication: This state is shown on the Replica Virtual Machine. This indicates that the replication is enabled for the virtual machine and a pointer has been created for the virtual machine at the Replica Server, but the initial replication has not been completed yet. On the Primary Server, the "ReadyForInitialReplication" replication state will be shown.
                #WaitingForStartResynchronize: A virtual machine may enter into this replication state if resynchronization needs to be done.
                default { Write-Host "3 HyperVReplica-$($VM.Name) syncsize=0 Unknown ReplicaHealth State: $($VM.ReplicationState)  Health: $($VM.ReplicationHealth)" }                    
            }

        }
    }
    Else {
        Write-Host "3 HyperVReplica - no VMs found. UAC issue?"
    } 
}
Catch {
    Write-Host  "3 VM Listing failed"
}