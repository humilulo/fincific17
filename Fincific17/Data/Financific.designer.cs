﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Fincific17.Data
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="FinDev3")]
	public partial class FinancificDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertProfile(Profile instance);
    partial void UpdateProfile(Profile instance);
    partial void DeleteProfile(Profile instance);
    #endregion
		
		public FinancificDataContext() : 
				base(global::System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public FinancificDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<Profile> Profiles
		{
			get
			{
				return this.GetTable<Profile>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.Profile")]
	public partial class Profile : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _Id;
		
		private System.Nullable<System.DateTime> _DeactivationDateUTC;
		
		private bool _IsActive;
		
		private System.Nullable<long> _AccountNumRoot;
		
		private string _AccountTitle;
		
		private string _FirstName;
		
		private string _LastName;
		
		private string _FirstNickName;
		
		private System.Nullable<long> _UniqueRand;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(int value);
    partial void OnIdChanged();
    partial void OnDeactivationDateUTCChanging(System.Nullable<System.DateTime> value);
    partial void OnDeactivationDateUTCChanged();
    partial void OnIsActiveChanging(bool value);
    partial void OnIsActiveChanged();
    partial void OnAccountNumRootChanging(System.Nullable<long> value);
    partial void OnAccountNumRootChanged();
    partial void OnAccountTitleChanging(string value);
    partial void OnAccountTitleChanged();
    partial void OnFirstNameChanging(string value);
    partial void OnFirstNameChanged();
    partial void OnLastNameChanging(string value);
    partial void OnLastNameChanged();
    partial void OnFirstNickNameChanging(string value);
    partial void OnFirstNickNameChanged();
    partial void OnUniqueRandChanging(System.Nullable<long> value);
    partial void OnUniqueRandChanged();
    #endregion
		
		public Profile()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DeactivationDateUTC", DbType="SmallDateTime")]
		public System.Nullable<System.DateTime> DeactivationDateUTC
		{
			get
			{
				return this._DeactivationDateUTC;
			}
			set
			{
				if ((this._DeactivationDateUTC != value))
				{
					this.OnDeactivationDateUTCChanging(value);
					this.SendPropertyChanging();
					this._DeactivationDateUTC = value;
					this.SendPropertyChanged("DeactivationDateUTC");
					this.OnDeactivationDateUTCChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_IsActive", DbType="Bit NOT NULL")]
		public bool IsActive
		{
			get
			{
				return this._IsActive;
			}
			set
			{
				if ((this._IsActive != value))
				{
					this.OnIsActiveChanging(value);
					this.SendPropertyChanging();
					this._IsActive = value;
					this.SendPropertyChanged("IsActive");
					this.OnIsActiveChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AccountNumRoot", DbType="BigInt")]
		public System.Nullable<long> AccountNumRoot
		{
			get
			{
				return this._AccountNumRoot;
			}
			set
			{
				if ((this._AccountNumRoot != value))
				{
					this.OnAccountNumRootChanging(value);
					this.SendPropertyChanging();
					this._AccountNumRoot = value;
					this.SendPropertyChanged("AccountNumRoot");
					this.OnAccountNumRootChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AccountTitle", DbType="NVarChar(50)")]
		public string AccountTitle
		{
			get
			{
				return this._AccountTitle;
			}
			set
			{
				if ((this._AccountTitle != value))
				{
					this.OnAccountTitleChanging(value);
					this.SendPropertyChanging();
					this._AccountTitle = value;
					this.SendPropertyChanged("AccountTitle");
					this.OnAccountTitleChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FirstName", DbType="NVarChar(144)")]
		public string FirstName
		{
			get
			{
				return this._FirstName;
			}
			set
			{
				if ((this._FirstName != value))
				{
					this.OnFirstNameChanging(value);
					this.SendPropertyChanging();
					this._FirstName = value;
					this.SendPropertyChanged("FirstName");
					this.OnFirstNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastName", DbType="NVarChar(144)")]
		public string LastName
		{
			get
			{
				return this._LastName;
			}
			set
			{
				if ((this._LastName != value))
				{
					this.OnLastNameChanging(value);
					this.SendPropertyChanging();
					this._LastName = value;
					this.SendPropertyChanged("LastName");
					this.OnLastNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FirstNickName", DbType="NVarChar(144)")]
		public string FirstNickName
		{
			get
			{
				return this._FirstNickName;
			}
			set
			{
				if ((this._FirstNickName != value))
				{
					this.OnFirstNickNameChanging(value);
					this.SendPropertyChanging();
					this._FirstNickName = value;
					this.SendPropertyChanged("FirstNickName");
					this.OnFirstNickNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UniqueRand", DbType="BigInt")]
		public System.Nullable<long> UniqueRand
		{
			get
			{
				return this._UniqueRand;
			}
			set
			{
				if ((this._UniqueRand != value))
				{
					this.OnUniqueRandChanging(value);
					this.SendPropertyChanging();
					this._UniqueRand = value;
					this.SendPropertyChanged("UniqueRand");
					this.OnUniqueRandChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
}
#pragma warning restore 1591